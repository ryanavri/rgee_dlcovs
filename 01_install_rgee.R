# STEP 1
install.packages("rgee")
library(rgee)

# STEP 2
install.packages("reticulate")
library(reticulate)

# STEP 3
reticulate::py_available()
reticulate::py_discover_config()

# STEP 4
rgee::ee_install_set_pyenv(
  py_path = "C:/Users/someone/AppData/Local/r-miniconda/envs/r-reticulate/python.exe", # PLEASE SET YOUR OWN PATH
  py_env = "rgee"
)

# STEP 5
rgee::ee_check()
rgee::ee_install_upgrade()

# initialize Earth Engine
rgee::ee_Initialize(
  user = "*****@gmail" # PLEASE SET YOUR OWN CREDENTIALS
)

# Up until this point, you need to run ee_check() again. if did not work. use following code

# Import rgee.
library(rgee)

# Attempt to authenticate. If credentials are found, nothing will happen except
# a return of TRUE. If credentials are not found, it'll take you through an auth
# flow and save the credentials. If you want to force reauthentication, include
# `force=TRUE` in the call. This is generally a one-time setup step.
ee$Authenticate(auth_mode='notebook')

# Initialize - this will connect to a project. You should always call this
# before working with rgee. It is IMPORTANT THAT YOU SPECIFY A PROJECT using
# the project parameter. If you forget what project IDs you have access to, find them
# here: console.cloud.google.com/project
ee$Initialize(project='ee-projectname')  # <-- EDIT THIS FOR YOUR PROJECT

# Optionally make a request to verify you are connected.
ee$String('Hello from the Earth Engine servers!')$getInfo()

