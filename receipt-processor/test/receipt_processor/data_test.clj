(ns receipt-processor.data-test
  (:require [clojure.test :refer :all]
            [receipt-processor.data :as data])
  (:import (java.time LocalDate LocalTime)))

(deftest processing
  (let [in 
        {:retailer "Target"
         :purchaseDate "2022-01-01"
         :purchaseTime "13:01"
         :items [{:shortDescription "Mountain Dew 12PK"
                  :price "6.49"}
                 {:shortDescription "Emils Cheese Pizza"
                  :price "12.25"}
                 {:shortDescription "Knorr Creamy Chicken"
                  :price "1.26"}
                 {:shortDescription "Doritos Nacho Cheese"
                  :price "3.35"}
                 {:shortDescription "   Klarbrunn 12-PK 12 FL OZ  "
                  :price "12.00"}]
         :total "35.35"}
        {:keys [items purchaseDate purchaseTime total] :as processed} (data/process in)]
  (testing "receipt processing"
    (are [k v] (= k v)
         purchaseDate (LocalDate/of 2022 1 1)
         purchaseTime (LocalTime/of 13 1)
         total 35.35M)
    (is (vector? items))
    (is (every? #(decimal? (:price %)) items))
    (is (= 24 (count (:shortDescription (last items))))))))

(deftest scoring
  (testing "scoring"
    (let [rec1 {:retailer "Target"
               :purchaseDate (LocalDate/of 2022 1 1)
               :purchaseTime (LocalTime/of 13 1)
               :items [{:shortDescription "Mountain Dew 12PK"
                        :price 6.49M}
                       {:shortDescription "Emils Cheese Pizza"
                        :price 12.25M}
                       {:shortDescription "Knorr Creamy Chicken"
                        :price 1.26M}
                       {:shortDescription "Doritos Nacho Cheese"
                        :price 3.35M}
                       {:shortDescription "Klarbrunn 12-PK 12 FL OZ"
                        :price 12.00M}]
               :total 35.35M}
          rec2 {:retailer "M&M Corner Market"
               :purchaseDate (LocalDate/of 2022 3 20)
               :purchaseTime (LocalTime/of 14 33)
               :items [{:shortDescription "Gatorade"
                        :price 2.25M}
                       {:shortDescription "Gatorade"
                        :price 2.25M}
                       {:shortDescription "Gatorade"
                        :price 2.25M}
                       {:shortDescription "Gatorade"
                        :price 2.25M}]
               :total 9.00M}]
      (are [receipt receipt-score] (= receipt-score (data/score receipt))
           rec1 28
           rec2 109))
    ))

;; (deftest end-to-end)
