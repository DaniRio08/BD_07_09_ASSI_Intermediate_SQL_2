import psycopg2

def insert_data(first_name, last_name, email, birthdate, age, photo_path):
    try:
        # Connect to the PostgreSQL database
        conn = psycopg2.connect(database="borja_moll", user="postgres",
                                password="postgres", host="localhost", port="5432")
        cur = conn.cursor()

        # Read the photo as binary data
        with open(photo_path, 'rb') as file:
            photo_data = file.read()

        # Execute the INSERT statement
        cur.execute("""
            INSERT INTO students(first_name, last_name, email, birthdate, age, photo)
            VALUES (%s, %s, %s, %s, %s, %s)
        """, (first_name, last_name, email, birthdate, age, psycopg2.Binary(photo_data)))

        # Commit the changes
        conn.commit()
        print("Data inserted successfully!")

    except (Exception, psycopg2.Error) as error:
        print("Error while connecting to PostgreSQL or inserting data:", error)

    finally:
        # Close the database connection
        if conn:
            cur.close()
            conn.close()
            print("PostgreSQL connection is closed")


insert_data('Daniel', 'Río', 'drioarizti@cifpfbmoll.eu', '2001-09-29', '21', 'Imagenes/daniimg.jpg')
insert_data('Raúl', 'Velásquez', 'rvelasquezvega@cifpfbmoll.eu', '1999-06-09', '23', 'Imagenes/raulimg.jpg')
insert_data('Juan', 'Pérez', 'jperez@cifpfbmoll.eu', '1995-10-12', '27', 'Imagenes/juanimg.jpg')