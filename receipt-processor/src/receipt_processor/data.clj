(ns receipt-processor.data
  (:require
    [clojure.string :as string])
  (:import
    java.math.BigDecimal
    (java.time LocalDate LocalTime)))

;; world's tiniest in-memory database
(defonce receipts (atom {}))

(def alphanumeric? (set "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"))

;; Scoring functions:

(defn alphanum
  "One point for every alphanumeric character in the retailer name."
  [r] (count (filter alphanumeric? (:retailer r))))

(defn total-round
  "50 points if the total is a round dollar amount with no cents."
  [r] (if (zero? (rem (:total r) 1)) 50 0))

(defn total-in-quarters
  "25 points if the total is a multiple of `0.25`."
  [r] (if (zero? (rem (:total r) 0.25)) 25 0))

(defn every-two
 "5 points for every two items on the receipt."
 [r] (* 5 (quot (count (:items r)) 2)))

(defn score-items
 "If the trimmed length of the item description is a multiple of 3,
 multiply the price by `0.2` and round up to the nearest integer.
 The result is the number of points earned."
  [r] (reduce +
          (map (fn [{:keys [shortDescription price]}]
                 (if (zero? (rem (count shortDescription) 3))
                   (.longValue (.setScale (* price 0.2M) 0 BigDecimal/ROUND_UP))
                   0))
               (:items r))))

(defn odd-day
 "6 points if the day in the purchase date is odd."
 [r] (if (odd? (.getDayOfMonth (:purchaseDate r))) 6 0))

(defn time-range
 "10 points if the time of purchase is after 2:00pm and before 4:00pm."
 [{:keys [purchaseTime]}]
  (if (and (.isAfter purchaseTime (LocalTime/of 14 0))
           (.isBefore purchaseTime (LocalTime/of 16 0)))
    10
    0))

(def scoring-rules
  "Stack of scoring rules, to be applied to a receipt map as produced by `process`"
  [alphanum total-round total-in-quarters every-two score-items odd-day time-range])

(defn process [raw-receipt]
  (do
  (-> raw-receipt
      (update :total bigdec)
      (update :purchaseDate #(LocalDate/parse %))
      (update :purchaseTime #(LocalTime/parse %))
      (update :items (partial mapv #(update % :price bigdec)))

      ;; currently our only scoring rule on item descriptions expects a
      ;; trimmed description, and I believe this to be a generally
      ;; reasonable preprocessing step in this domain. if we do add a
      ;; scoring rule not expecting a trimmed description, move this
      ;; into `score-items` above (JP 2024/12/17))
      (update :items (partial mapv #(update % :shortDescription string/trim)))
  )))

(defn score [receipt]
  (reduce +
          (map ;; could be parallel `pmap` for performance, if that becomes a concern
            #(% receipt) scoring-rules)))

(defn process! [raw-receipt]
  (let [receipt-score (-> raw-receipt
                  process
                  score)
        id (.toString (random-uuid))]
  (swap! receipts assoc id receipt-score)
  id))

(defn lookup [id]
  (get @receipts id))
