import json
import random

from flask import Blueprint, current_app, jsonify, make_response, request
from src import db

review_responses = Blueprint("review_responses", __name__)


# Get all user interactions from the database
@review_responses.route("/review_responses", methods=["GET"])
def get_review_responses():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute("SELECT CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate FROM Review_Response")

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers.
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


@review_responses.route("/review_responses/review_id/<review_id>", methods=["GET"])
def get_review_responses_detail_review_id(review_id):
    query = (
        "SELECT CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate FROM Review_Response WHERE ReviewID = "
        + str(review_id)
    )
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

@review_responses.route("/review_responses/company_rep_id/<company_rep_id>", methods=["GET"])
def get_review_responses_detail_review_responses_id(company_rep_id):
    query = (
       "SELECT CompanyRepID, ReviewID, ResponseID, ResponseContent, ResponseDate FROM Review_Response WHERE CompanyRepID = "
        + str(company_rep_id)
    )
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)