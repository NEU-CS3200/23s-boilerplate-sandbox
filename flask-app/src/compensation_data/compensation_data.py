import json
import random

from flask import Blueprint, current_app, jsonify, make_response, request
from src import db

compensation_data = Blueprint("compensation_data", __name__)


# Get all user interactions from the database
@compensation_data.route("/compensation_data", methods=["GET"])
def get_compensation_data():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute(
        "SELECT CompensationID, AverageSalary, CompanyPageID FROM Compensation_Data"
    )

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

@compensation_data.route('/compensation_data/company_page_id/<company_page_id>', methods=['GET'])
def get_compensation_data_detail_company_page_id (company_page_id):

    query = 'SELECT CompensationID, Positiontype, AverageSalary, FilterCriteria, CompanyPageID FROM Compensation_Data WHERE CompanyPageID = ' + str(company_page_id)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

@compensation_data.route('/compensation_data/compensation_id/<compensation_id>', methods=['GET'])
def get_compensation_data_detail_compensation_id (compensation_id):

    query = 'SELECT CompensationID, Positiontype, AverageSalary, FilterCriteria, CompanyPageID FROM Compensation_Data WHERE CompensationID = ' + str(compensation_id)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)