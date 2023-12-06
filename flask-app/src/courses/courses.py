from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


courses = Blueprint('courses', __name__)

# Get all courses from the DB
@courses.route('/courses', methods=['GET'])
def get_courses():
    cursor = db.get_db().cursor()
    cursor.execute('select name, term from course')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Make a new course
@courses.route('/courses', methods=['POST'])
def add_new_course():
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    name = the_data['course_name']
    term = the_data['course_term']
    department = the_data['course_department']
    professor = the_data['course_professor']

    # Constructing the query
    query = 'insert into course (name, term, department, professor) values ("'
    query += name + '", "'
    query += term + '", "'
    query += str(department) + '", '
    query += str(professor) + ')'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

# Get course detail for a specfifc course
@courses.route('/courses/<cID>', methods=['GET'])
def get_course(cID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from course where courseID = {0}'.format(cID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Modify a course with the given id
@courses.route('/courses/<cID>', methods=['PUT'])
def modify_course(cID):
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    name = the_data['course_name']
    term = the_data['course_term']
    department = the_data['course_department']
    professor = the_data['course_professor']

    # Constructing the query
    query = 'update course set name = "'
    query += name + '", term = "'
    query += term + '", department = '
    query += str(department) + ', professor = '
    query += str(professor) + ' where courseID = {0})'.format(cID)
    current_app.logger.info(query)

    # executing and committing the update statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

# Delete a course with the given id
@courses.route('/courses/<cID>', methods=['DELETE'])
def delete_course(cID):
    cursor = db.get_db().cursor()
    cursor.execute('delete from course where courseID = {0}'.format(cID))
    db.get_db().commit()
    return 'Success!'

# Get all assignments for a specfifc course
@courses.route('/courses/<cID>/assignments', methods=['GET'])
def get_course_assignments(cID):
    cursor = db.get_db().cursor()
    current_app.logger.info('select assignment.assignmentID, assignment.title, section.secID as sectionID' 
                   + ' from assignment join section on assignment.section = section.secID where section.course = {0}'.format(cID))
    cursor.execute('select assignment.assignmentID, assignment.title, section.secID as sectionID' 
                   + ' from assignment join section on assignment.section = section.secID where section.course = {0}'.format(cID))
    
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Delete all assignments with the given course id
@courses.route('/courses/<cID>/assignments', methods=['DELETE'])
def delete_course_assignments(cID):
    cursor = db.get_db().cursor()
    cursor.execute('delete from assignment where section in ('
        + 'select secID from section where course = {0})'.format(cID))
    db.get_db().commit()
    return 'Success!'

# Add a new assignment to all sections of a course
@courses.route('/courses/<cID>/assignments', methods=['POST'])
def add_new_course_assignment(cID):
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)
    #extracting the variable
    title = the_data['title']
    # Constructing the query
    query = 'insert into assignment (title, section) select "'
    query += title + '", secID from section where course = {0}'.format(cID)
    current_app.logger.info(query)
    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Success!'

# Get a specific assignment information
@courses.route('/courses/assignment/<aID>', methods=['GET'])
def get_assignment(aID):
    cursor = db.get_db().cursor()
    cursor.execute('select assignment.assignmentID, assignment.title, section.secID as sectionID, section.course as courseID'
                    + ' from assignment join section on assignment.section = section.secID where assignment.assignmentID = {0}'.format(aID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


# Modify an assignment with a given id
@courses.route('/courses/assignment/<aID>', methods=['PUT'])
def modify_assignment(aID):
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)
    #extracting the variable
    title = the_data['title']
    # Constructing the query
    query = 'update assignment set title = "'
    query += title + '", where assignmentID = {0})'.format(aID)
    current_app.logger.info(query)
    # executing and committing the update statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    return 'Success!'

# Delete a specific assignment
@courses.route('/courses/assignment/<aID>', methods=['DELETE'])
def delete_assignment(aID):
    cursor = db.get_db().cursor()
    cursor.execute('delete from assignment where assignmentID = {0})'.format(aID))
    db.get_db().commit()
    return 'Success!'