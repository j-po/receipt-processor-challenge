(ns receipt-processor.core
  (:require 
    [compojure.core :refer [defroutes GET POST]]
    [compojure.route :refer [not-found]]
    [org.httpkit.server :refer [run-server]]
    [ring.middleware.json :refer [wrap-json-body]]
    [receipt-processor.data :as data])
  (:import java.io.ByteArrayInputStream)
  (:gen-class))

(defroutes all-routes
  (POST "/receipts/process"
        {body :body}
        (do
          (if-let [id (try (data/process! body)
                           (catch Exception e
                             (do
                               (println e)
                               nil)))]
            {:status 200
             :headers {"Content-Type" "application/json"}
             :body (str "{\"id\": \"" id "\"}")}
            {:status 400})))
  (GET ["/receipts/:id/points"
        :id #"\S+"]
       [id]
       (if-let [points (data/lookup id)]
         {:status 200
          :headers {"Content-Type" "application/json"}
          :body (str "{\"points\": " points "}")}
         {:status 404}))
  (GET "/testing"
       []
       {:status 200})
  (not-found nil)) ;;TODO: actual logging and metrics

(def wrapped-routes
  (wrap-json-body all-routes {:keywords? true}))

(defn -main []
  (do
    (println "running server")
    (run-server wrapped-routes {:port 8080 :event-logger println
                                       :error-logger println
                                       :warn-logger println})))
