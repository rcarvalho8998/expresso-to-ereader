# Calibre

Calibre here serves as a database of books (self-managed by calibre and should not be touched), which is is under: "/config/Calibre Library".

Ebooks are added to the /import folder which is shared with readarr's download folder.

There is a web interface in port "8780" (maps to 8080 in container)

# Setup
To start the calibre image you just need to run the command:
```bash
    docker compose up -d
```
Access the <server_address>:8780 to get to the GUI.
To automatically enable calibre to import the books, you need to:
1. Click on "Add Books"'s down arrow

2. Click on "Control the adding of books"

3. Go to "Automatic adding" Tab

4. Specify the "/import" folder

5. Restart the container.

Aftwards all book put in that folder will be added to the Calibre Database.


# Using ebook-convert
Calibre comes with the ebook-convert library which is typically used to convert ebooks or even web pages to the desired format.

While the container is running we can access the command using docker's exec command.

### Example
Here I'm trying to use the expresso.recipe to download web pages from expresso.pt to epub format.
```bash
    docker exec --user 1000 calibre ebook-convert ./recipes/expresso.recipe /import/expresso.epub  --username <expresso_username> --password <expresso_password>
```
We need to add the `--user 1000` flag in the docker command because this os defined as the user that can control calibre's files as you can see in the docker-compose:
```yaml
  calibre:
    image: lscr.io/linuxserver/calibre
    container_name: calibre
    environment: 
      - PUID=1000
      - PGID=1000
```

The ebook-convert has these commands:

1. ebook-convert

2. <recipe_file_location> (which is inside the container)

3. <output_file_location> (which is inside the container)

4. <output_ebook_format>

5. <recipe_arguments>..

    1. --username <username> (specific to expresso.recipe)

    1. --password <password> (specific to expresso.recipe)
