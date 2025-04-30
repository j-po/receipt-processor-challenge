import json
import os
import urllib.request as req
from uuid import uuid4

def test_receipt(filename, points_expected, host="http://127.0.0.1", port=os.environ.get("LOCAL_PORT", default="8080")):
    print(f"Testing {filename}")
    urlroot = ":".join([host, port])
    with open(filename, "rb") as f:
        process_request = req.Request(urlroot + "/receipts/process",
                data = f.read(),
                headers = {"Content-Type": "application/json"})
    process_response = req.urlopen(process_request)
    assert process_response.status == 200
    receipt_id = json.load(process_response)["id"]
    assert receipt_id is not None

    points_response = req.urlopen("/".join([urlroot, "receipts", receipt_id, "points"]))
    assert points_response.status == 200
    assert json.load(points_response)["points"] == points_expected


if __name__ == "__main__":

    examples = [("morning-receipt", 15),
            ("simple-receipt", 31),
            ("target", 28),
            ("m-m-corner-market", 109)]

    for f, p in examples:
        test_receipt("".join(["examples/", f, ".json"]) , p)

#TODO: test some failures
