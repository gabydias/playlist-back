# -*- coding: utf-8 -*-
import os
import sys
import unittest
import pytest
import pymysql 

cur_dir = os.getcwd()
sys.path.append(f'{cur_dir}/..')

from app import app

# Setup of the place referred to in phpunit, teardown makes use of the fixture.
@pytest.fixture(scope="module")
def conn():
  conn = pymysql.connect(
    host="localhost",
    user="playuser",
    password="123456",
    db="playlist",
    charset="utf8",
    cursorclass=pymysql.cursors.DictCursor )

  yield conn
  conn.close()

@pytest.fixture
def cursor(conn):
  cursor = conn.cursor()
  yield cursor

@pytest.fixture
def initialize(cursor):
  print("Create Table")
  cursor.execute('CREATE TABLE songs ( id int, name varchar(20))')

def test_created_table(cursor, initialize):
  cursor.execute("SELECT * FROM songs")
  result = cursor.fetchall()
  assert len(result) == 0

def setUp(self):
  # cria uma instância do unittest, precisa do nome "setUp"
  self.app = app.test_client()

  # envia uma requisicao GET para a URL
  self.result = self.app.get('/')

  # compara o status da requisicao (precisa ser igual a 200)
  self.assertEqual(self.result.status_code, 200)

@pytest.fixture
def delete_table(cursor):
  print("Delete Table")
  cursor.execute("DROP TABLE songs")

def test_delete_table(cursor, delete_table):
  cursor.execute("SELECT table_name FROM information_schema.tables where table_name = 'songs';")
  result = cursor.fetchall()
  assert len(result) == 0
