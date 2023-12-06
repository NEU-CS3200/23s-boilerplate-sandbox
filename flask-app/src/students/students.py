from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

students = Blueprint('student', __name__)
courses_in_section = Blueprint('student_in_section',__name__)

# Get all students from the database 
@students.route('/students', methods=['GET'])
def get_students():
    # get a cursor object from the database
    cursor = db.get_db().cursor()
    # use cursor to query the database for a list of students
    cursor.execute('SELECT * FROM student')

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


@students.route('/students', methods=['POST'])
def add_new_student():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    firstName = the_data['first_name']
    lastName = the_data['last_name']
    gender = the_data['gender']
    email = the_data['email'] 
    gradYear = the_data['grad_year'] 
    address = the_data['address']
    major = the_data['major']
    department = the_data['department']
    advisor = the_data['advisor']

    # Constructing the query
    query = 'insert into student (firstName, lastName, address, gender, email, major, advisor, department, gradYear) values ("'
    query += firstName + '", "'
    query += lastName + '", "'
    query += address + '", "'
    query += gender + '", "'
    query += email + '", "'
    query += str(major) + '", "'
    query += str(advisor) + '", "'
    query += str(department) + '", "'
    query += str(gradYear) + '"' + ')'

    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'


@students.route('/student/<id>', methods=['GET'])
def get_student_detail(id):
    query = 'SELECT * FROM student WHERE studentID = ' + str(id)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)
    

@students.route('/student/<id>', methods=['PUT'])
def update_student(id):
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    firstName = the_data['first_name']
    lastName = the_data['last_name']
    gender = the_data['gender']
    email = the_data['email'] 
    gradYear = the_data['grad_year'] 
    address = the_data['address']
    major = the_data['major']
    department = the_data['department']
    advisor = the_data['advisor']

    # Constructing the query
    query = 'update student set '
    query += "firstName = " + '"'+ firstName + '", '
    query += "lastName = " + '"'+ lastName + '", '
    query += "address = " + '"' + address + '", '
    query += "gender = " + '"' + gender + '", '
    query += "email = " + '"'+ email + '", '
    query += "major = " + str(major) + ', '
    query += "advisor = " + str(advisor) + ', '
    query += "department = " + str(department) + ', '
    query += "gradYear = " + str(gradYear) + ' WHERE studentID = ' + str(id)

    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'


@students.route('/student/<id>', methods=['DELETE'])
def delete_student(id):
    query = 'DELETE FROM student WHERE studentID = ' + str(id)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

@courses_in_section.route('/sections/<section_id>/student/<student_id>', methods=['POST'])
def add_student_in_section(section_id, student_id):
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    courseGrade = the_data['course_grade']
    query = 'INSERT INTO students_in_section (section, student, courseGrade) '
    query += 'values ('
    query += str(section_id) + " , "
    query += str(student_id) + " , " 
    query += '"' + courseGrade + '" )'

    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'





