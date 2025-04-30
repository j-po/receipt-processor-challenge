(ns receipt-processor.core-test
  (:require [clojure.java.io :as io]
            [clojure.test :refer :all]
            [cheshire.core :as json]
            [receipt-processor.core :refer :all])
  (:import java.io.ByteArrayInputStream))

(def rec1 
"{
  \"retailer\": \"Target\",
  \"purchaseDate\": \"2022-01-01\",
  \"purchaseTime\": \"13:01\",
  \"items\": [
    {
      \"shortDescription\": \"Mountain Dew 12PK\",
      \"price\": \"6.49\"
    },{
      \"shortDescription\": \"Emils Cheese Pizza\",
      \"price\": \"12.25\"
    },{
      \"shortDescription\": \"Knorr Creamy Chicken\",
      \"price\": \"1.26\"
    },{
      \"shortDescription\": \"Doritos Nacho Cheese\",
      \"price\": \"3.35\"
    },{
      \"shortDescription\": \"   Klarbrunn 12-PK 12 FL OZ  \",
      \"price\": \"12.00\"
    }
  ],
  \"total\": \"35.35\"
}")

(def rec2 
"{
  \"retailer\": \"M&M Corner Market\",
  \"purchaseDate\": \"2022-03-20\",
  \"purchaseTime\": \"14:33\",
  \"items\": [
    {
      \"shortDescription\": \"Gatorade\",
      \"price\": \"2.25\"
    },{
      \"shortDescription\": \"Gatorade\",
      \"price\": \"2.25\"
    },{
      \"shortDescription\": \"Gatorade\",
      \"price\": \"2.25\"
    },{
      \"shortDescription\": \"Gatorade\",
      \"price\": \"2.25\"
    }
  ],
  \"total\": \"9.00\"
}")

(defn receipt-score [body]
    (when-let [id (-> {:request-method :post
                             :headers {"content-type" "application/json"}
                             :uri "/receipts/process"
                             :body body}
                            wrapped-routes
                            :body
                            (json/parse-string true)
                            :id)]
      (-> {:request-method :get
           :uri (str "/receipts/" id "/points")}
          wrapped-routes
          :body
          (json/parse-string true)
          :points)))

(deftest receipts
  (are [receipt points] (with-open [receipt-stream (ByteArrayInputStream. (.getBytes receipt))]
                          (= points (receipt-score receipt-stream)))
       rec1 28
       rec2 109)
  (are [filename points] (with-open [receipt-stream (io/input-stream
                                                      (io/resource (str "examples/" filename ".json")))]
                           (= points (receipt-score receipt-stream)))
       "morning-receipt" 15
       "simple-receipt" 31))
