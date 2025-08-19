#!/usr/bin/env python3
import requests
from bs4 import BeautifulSoup
import firebase_admin
from firebase_admin import credentials, firestore
from dotenv import load_dotenv
import os

load_dotenv()
key_path = os.getenv("FIREBASE_KEY")

# Initialize Firebase app
cred = credentials.Certificate(key_path)
firebase_admin.initialize_app(cred)
db = firestore.client()

# Scrape data
URL = "https://dining.ucla.edu/Hours/"
response = requests.get(URL)

if(response.status_code != 200):
    raise Exception(f"Failed to fetch data: {response.status_code}")

soup = BeautifulSoup(response.text, 'html.parser')

# Parse name and hour
dining_data = []

# Locate the hours table by class
table = soup.find("table", class_="dining-hours-table")
if not table:
    raise Exception("Couldn't find dining-hours-table on the page.")

rows = table.select("tbody tr") # Selects all <tr> in <tbody> of the table
for row in rows:
    cols = row.find_all("td")
    if len(cols) < 5:
        continue

    name_tag = cols[0].find("a")
    if not name_tag:
        continue

    dining_name = name_tag.text.strip()

    meals = ["Breakfast", "Lunch", "Dinner", "Extended Dinner"]
    hours = {}

    for i in range(1, 5):
        meal_time = cols[i].text.strip()
        hours[meals[i - 1]] = meal_time
    
    dining_data.append({
        "name": dining_name,
        "hours": hours
    })

# Store in Firebase
collection_ref = db.collection("dining_halls")

for entry in dining_data:
    doc_ref = collection_ref.document(entry["name"])
    doc_ref.set({
        "name": entry["name"],
        "hours": entry["hours"]
    })

print("Dining hall data successfully uplodaed to Firestore")