# Wayat Backend

# Run the application
In this section you will find an overview on how to execute and configure the project.

## Dependencies
Dependencies are automatically managed by **Poetry**

To install dependencies run
```bash
poetry install
```
in same folder where your `.toml` file is located. 
Poetry will take care of:
- Installing the required Python interpreter 
- Installing all the libraries and modules 
- Creating the virtual environment for you

Refer to [this link](https://www.jetbrains.com/help/pycharm/poetry.html) to configure Poetry on PyCharm

## Running on local

You can launch the uvicorn server programmatically running directly the main.py file.

```shell
python main.py
```

It is also possible to start the uvicorn live directly server with the command:

```shell
uvicorn main:api --reload
```

- **_main_**: the file main.py (the Python "module").
- **_app_**: the object created inside of main.py with the line app = FastAPI().
- _**--reload**_: make the server restart after code changes. Only use for development.


## Environment Configuration

You can use Pydantic Settings to handle the settings or configurations for your application, with all the power of Pydantic models. The project uses Dependency Injection for managing dependencies across the application and easy mocking for testing.

**Create an **_.env_** file for each environment configuration**. The use of @lru_cache() lets you avoid reading the dotenv file again and again for each request, while allowing you to override it during testing.

Even when using a dotenv file, the application will still read environment variables as well as the dotenv file, **environment variables will always take priority over values loaded from a dotenv file**.

You can also specify the environment when launching the server. Corresponding **_.env_** file will be automatically loaded.

Settings and environment variables are managed by **Pydantic**, refer to [the documentation](https://pydantic-docs.helpmanual.io/usage/settings/) for more info.

```
ENV=PROD uvicorn main:app --reload
ENV=PROD python main.py
```

### Host & Port Configuration
The Port and Hosting configuration can be set directly on the **.env** file if launching the main.py file.

However, this configuration is related with the uvicorn server itself and can also be set with the _**--port [int]**_ flag. 

Refer to the [uvicorn documentation](https://www.uvicorn.org/settings/) for more info.

### Logging Configuration
The application uses the default **_logging_** module.

To use it inside an specific module init it first with the command:

```
logger = logging.getLogger(__name__)
```

You can use the __name__ variable to take the current file name as the default or specify a custom module name manually.

Configure the logging properties in the **_logging.yaml_** file. 
You can find more information in the [logging](https://docs.python.org/3/library/logging.html#module-logging) documentation.

## Git Management

The Wayat repository has `devon4py` as a subtree prefixed at `wayat/backend`. This allows us to bring new changes in the
framework to the project easily. To do so, first we need to add `devon4py` as a remote:
```shell
git remote add devon4py https://github.com/devonfw-forge/devon4py.git
```

Once we have added the remote, we can bring new changes that were made in the `devon4py' repository by
running:
```shell
git pull -s subtree --allow-unrelated-histories --no-commit --squash devon4py main
```

This will bring all the changes but won't commit them, so that we can decide what to merge in a new unique commit.
