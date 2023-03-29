import psycopg2
import io
from PIL import Image

def retrieve_image(student_id, photo_path):
    try:
        # Connect to the PostgreSQL database
        conn = psycopg2.connect(database="borja_moll", user="postgres",
                                password="radrax*88", host="localhost", port="5432")
        cur = conn.cursor()

        # Execute the SELECT statement
        cur.execute("""
            SELECT photo
            FROM students
            WHERE student_id = %s
        """, (student_id,))

        # Fetch the photo data
        photo_data = cur.fetchone()[0]

        # Save the photo to a file
        with open(photo_path, 'wb') as file:
            file.write(photo_data)

        # Open the photo with PIL and display it
        with Image.open(io.BytesIO(photo_data)) as img:
            img.show()

        print("Photo retrieved successfully!")

    except (Exception, psycopg2.Error) as error:
        print("Error while connecting to PostgreSQL or retrieving data:", error)

    finally:
        # Close the database connection
        if conn:
            cur.close()
            conn.close()
            print("PostgreSQL connection is closed")

retrieve_image(1, 'Imagenes/retrieved_photo.jpg')