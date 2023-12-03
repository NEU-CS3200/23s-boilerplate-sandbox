import json
import random

from flask import Blueprint, current_app, jsonify, make_response, request
from src import db

analytics = Blueprint("analytics", __name__)


# Get all user interactions from the database
@analytics.route("/analytics", methods=["GET"])
def get_analytics():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute("SELECT AnalyticsID, EngagementScore, TrendType, Data FROM Analytics")

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


@analytics.route("/analytics/moderator_id/<moderator_id>", methods=["GET"])
def get_analytics_detail_moderator_id(moderator_id):
    query = (
        "SELECT ModeratorID, AnalyticsID, EngagementScore, TrendType, Data FROM Analytics WHERE ModeratorID = "
        + str(moderator_id)
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

@analytics.route("/analytics/analytics_id/<analytics_id>", methods=["GET"])
def get_analytics_detail_analytics_id(analytics_id):
    query = (
        "SELECT ModeratorID, AnalyticsID, EngagementScore, TrendType, Data FROM Analytics WHERE AnalyticsID = "
        + str(analytics_id)
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