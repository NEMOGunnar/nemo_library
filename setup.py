import os
from setuptools import setup, find_packages

# Determine the absolute path to the requirements.txt file
base_dir = os.path.abspath(os.path.dirname(__file__))
requirements_path = os.path.join(base_dir, 'requirements.txt')

# Read the contents of the requirements.txt file
with open(requirements_path) as f:
    required = f.read().splitlines()

# Import the version from nemo_library.version
from nemo_library.version import __version__

# Setup configuration for the Python package
setup(
    name='nemo_library',  # Name of the package
    version=__version__,  # Version of the package imported from version.py
    packages=find_packages(),  # Automatically find and include all packages
    install_requires=required,  # List of dependencies from requirements.txt
    include_package_data=True,
    package_data={
        'nemo_library': ['templates/migmantemplates.json'],
    },    
    author='Gunnar Schug',  # Author of the package
    author_email='GunnarSchug81@gmail.com',  # Author's email address
    description='A Python library for data management, project automation, and integration with the NEMO cloud solution',  # Updated short description
    long_description=open('README.rst').read(),  # Long description read from README.rst
    long_description_content_type='text/x-rst',  # Content type for the long description
    classifiers=[
        'Programming Language :: Python :: 3.13',  # Classifier indicating supported Python version
    ],
    project_urls={
        'Github': 'https://github.com/H3rm1nat0r/nemo_library',  # URL to the project's GitHub repository
        'NEMO': 'https://enter.nemo-ai.com/nemo/'  # URL to the NEMO cloud solution
    },
)