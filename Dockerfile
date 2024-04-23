#Setting up the container
FROM python:3.11-slim

# This copies everything in current directory to /app directory in the container.
COPY . /app 

# This sets up the /app directory as the working directory for any RUN,CMD,ENTRYPOINT or COPY instruction that follow
WORKDIR /app

RUN pip install --upgrade pip
 
# This installs the dependencies written in the requirements.txt file
RUN pip install --default-timeout=3000 -r requirements.txt

# This tells docker to listen on pert 80 at run time. Port 80 is the standard http port
EXPOSE 80

# This command creates a .streamlit directory in the directory of the container.
RUN mkdir ~/.streamlit

# This copies our Streamlit configuration file and credenttials file into the .streamlit directory we just created.
RUN cp config.toml ~/.streamlit/config.toml
RUN cp credentials.toml ~/.streamlit/credentials.toml

# This sets the default command for the container to run the app with Streamlit.
ENTRYPOINT ["streamlit", "run"]

# This command tells Streamlit to run your app.py script when the container starts.
CMD ["app.py"]
