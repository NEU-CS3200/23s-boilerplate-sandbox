import json
import random

from flask import Blueprint, current_app, jsonify, make_response, request
from src import db

reviews = Blueprint('reviews', __name__)
# Get all reviews from the databas
@reviews.route('/reviews', methods = ['GET'])
def get_reviews():
     # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute('SELECT ReviewID, JobID, Comment, DifficultyRating, FirstOrSecondCoop FROM Reviews')

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

@reviews.route('/reviews', methods=['POST'])
def add_new_review():

    # collecting data from the request object
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    company_page_id = the_data['CompanyPageID']
    job_id = the_data['JobID']
    student_id = the_data['StudentID']
    review_id = random.randint(0,999999999)
    comment = the_data['Comment']
    difficulty_rating = the_data['DifficultyRating']
    first_or_second_coop = the_data['FirstOrSecondCoop']

    # Constructing the query
    query = 'insert into Reviews (CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop) values ('
    query += str(company_page_id) + ', '
    query += str(job_id) + ', '
    query += str(student_id) + ', '
    query += str(review_id) + ', "'
    query += comment + '", '
    query += str(difficulty_rating) + ', "'
    query += first_or_second_coop + '")'
    current_app.logger.info(query)

    # executing and committing the insert statement
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Success!'

@reviews.route('/reviews/<review_id>', methods=['PUT'])
def update_review(review_id):

    # collecting data from the request object
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    review_id = review_id
    comment = the_data['Comment']
    difficulty_rating = the_data['DifficultyRating']
    first_or_second_coop = the_data['FirstOrSecondCoop']

    # Constructing the query
    query = 'update Reviews set '


    query += 'Comment = "' + comment + '", '
    query += 'DifficultyRating = ' + str(difficulty_rating) + ', '
    query += 'FirstOrSecondCoop = "' + first_or_second_coop + '" '

    query += 'where ReviewID = '
    query += str(review_id)
    query += ";"
    current_app.logger.info(query)

    # executing and committing the insert statement
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Success!'

@reviews.route('/reviews/<review_id>', methods=['GET'])
def get_review_detail (review_id):

    query = 'SELECT CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop FROM Reviews WHERE ReviewID = ' + str(review_id)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

@reviews.route('/reviews/company_page_id/<company_page_id>', methods=['GET'])
def get_review_detail_company_page_id (company_page_id):

    query = 'SELECT CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop FROM Reviews WHERE CompanyPageID = ' + str(company_page_id)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

@reviews.route('/reviews/job_id/<job_id>', methods=['GET'])
def get_review_detail_job (job_id):

    query = 'SELECT CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop FROM Reviews WHERE JobID = ' + str(job_id)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

@reviews.route('/reviews/student_id/<student_id>', methods=['GET'])
def get_review_detail_student_id (student_id):

    query = 'SELECT CompanyPageID, JobID, StudentID, ReviewID, Comment, DifficultyRating, FirstOrSecondCoop FROM Reviews WHERE StudentID = ' + str(student_id)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

@reviews.route('/reviews/<review_id>', methods=['DELETE'])
def delete_review (review_id):

    query = 'DELETE FROM Reviews WHERE ReviewID = ' + str(review_id)
    current_app.logger.info(query)

    # executing and committing the insert statement
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Success!'