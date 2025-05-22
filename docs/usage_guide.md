# NEMO Library Usage Guide

## Overview

The **NEMO Library** is a versatile Python library that simplifies data management, project automation, and reporting within the NEMO cloud solution. It also supports integration with external systems like HubSpot, making it a powerful tool for streamlining workflows and enhancing productivity.

---

## Installation

Checkout the [Installation Guide](https://github.com/H3rm1nat0r/nemo_library/blob/master/docs/setup_guide.md).

---

## Class Overview

### NemoLibrary

The central class of the library. Instantiating this class gives access to all functions.

#### Initialization

```python
from nemo_library import NemoLibrary

# Example instance
nemo = NemoLibrary()
```

---

## Method Overview

### Project Management

- **`getProjects()`**
  - **Description:** Fetches a list of all projects.
  - **Example:**
    ```python
    projects = nemo.getProjects()
    print(projects)
    ```

- **`getProjectID(projectname: str)`**
  - **Description:** Retrieves the unique project ID for a given project name.
  - **Example:**
    ```python
    project_id = nemo.getProjectID("ExampleProject")
    print(project_id)
    ```

- **`createProjects(projects: list[Project])`**
  - **Description:** Creates or updates a list of projects.
  - **Example:**
    ```python
    nemo.createProjects([Project(name="New Project", description="Description")])
    ```

- **`deleteProjects(projects: list[str])`**
  - **Description:** Deletes a list of projects by their IDs.
  - **Example:**
    ```python
    nemo.deleteProjects(["ProjectID1", "ProjectID2"])
    ```

- **`getProjectProperty(projectname: str, propertyname: str)`**
  - **Description:** Retrieves a specific property value of a given project.
  - **Example:**
    ```python
    property_value = nemo.getProjectProperty("ExampleProject", "propertyName")
    print(property_value)
    ```

- **`setProjectMetaData(projectname: str, processid_column: str, processdate_column: str, corpcurr_value: str)`**
  - **Description:** Updates metadata for a specific project.
  - **Example:**
    ```python
    nemo.setProjectMetaData("ExampleProject", "ProcessID", "ProcessDate", "USD")
    ```

---

### Data Management

- **`ReUploadFile(projectname: str, filename: str)`**
  - **Description:** Re-uploads a file to a specified project and triggers data ingestion.
  - **Example:**
    ```python
    nemo.ReUploadFile("ExampleProject", "data.csv")
    ```

- **`ReUploadDataFrame(projectname: str, df: pd.DataFrame)`**
  - **Description:** Re-uploads a DataFrame to a specified project and triggers data ingestion.
  - **Example:**
    ```python
    nemo.ReUploadDataFrame("ExampleProject", dataframe)
    ```

- **`synchronizeCsvColsAndImportedColumns(projectname: str, filename: str)`**
  - **Description:** Synchronizes the columns from a CSV file with the imported columns in a project.
  - **Example:**
    ```python
    nemo.synchronizeCsvColsAndImportedColumns("ExampleProject", "data.csv")
    ```

---

### Reporting

- **`LoadReport(projectname: str, report_guid: str = None, report_name: str = None)`**
  - **Description:** Loads a report from a project and returns the data as a Pandas DataFrame.
  - **Example:**
    ```python
    report = nemo.LoadReport("ExampleProject", report_name="ExampleReport")
    print(report)
    ```

- **`createReports(projectname: str, reports: list[Report])`**
  - **Description:** Creates or updates a list of reports.
  - **Example:**
    ```python
    nemo.createReports("ExampleProject", [Report(name="New Report", query="SELECT * FROM Table")])
    ```

- **`deleteReports(reports: list[str])`**
  - **Description:** Deletes a list of reports by their IDs.
  - **Example:**
    ```python
    nemo.deleteReports(["ReportID1", "ReportID2"])
    ```

---

### Metadata Management

- **`MetaDataLoad(projectname: str, prefix: str)`**
  - **Description:** Loads metadata for a specified project.
  - **Example:**
    ```python
    nemo.MetaDataLoad("ExampleProject", "prefix")
    ```

- **`MetaDataCreate(projectname: str, prefix: str)`**
  - **Description:** Creates metadata for a specified project.
  - **Example:**
    ```python
    nemo.MetaDataCreate("ExampleProject", "prefix")
    ```

- **`MetaDataDelete(projectname: str, prefix: str)`**
  - **Description:** Deletes metadata for a specified project.
  - **Example:**
    ```python
    nemo.MetaDataDelete("ExampleProject", "prefix")
    ```

---

### Focus Management

- **`focusMoveAttributeBefore(projectname: str, sourceDisplayName: str, targetDisplayName: str)`**
  - **Description:** Moves an attribute in the focus tree of a project, positioning it before a target attribute.
  - **Example:**
    ```python
    nemo.focusMoveAttributeBefore("ExampleProject", "SourceAttribute", "TargetAttribute")
    ```

- **`focusCoupleAttributes(projectname: str, attributenames: list[str], previous_attribute: str)`**
  - **Description:** Couples attributes in the focus tree of a project.
  - **Example:**
    ```python
    nemo.focusCoupleAttributes("ExampleProject", ["Attribute1", "Attribute2"], "PreviousAttribute")
    ```

---

### Migration Management

- **`MigManInitDatabase()`**
  - **Description:** Initializes the migration database.
  - **Example:**
    ```python
    nemo.MigManInitDatabase()
    ```

- **`MigManCreateProjectTemplates()`**
  - **Description:** Creates project templates for migration.
  - **Example:**
    ```python
    nemo.MigManCreateProjectTemplates()
    ```

- **`MigManDeleteProjects()`**
  - **Description:** Deletes projects for migration.
  - **Example:**
    ```python
    nemo.MigManDeleteProjects()
    ```

- **`MigManLoadData()`**
  - **Description:** Loads data for migration.
  - **Example:**
    ```python
    nemo.MigManLoadData()
    ```

- **`MigManCreateMapping()`**
  - **Description:** Creates mapping for migration.
  - **Example:**
    ```python
    nemo.MigManCreateMapping()
    ```

- **`MigManLoadMapping()`**
  - **Description:** Loads mapping for migration.
  - **Example:**
    ```python
    nemo.MigManLoadMapping()
    ```

- **`MigManApplyMapping()`**
  - **Description:** Applies mapping for migration.
  - **Example:**
    ```python
    nemo.MigManApplyMapping()
    ```

- **`MigManExportData()`**
  - **Description:** Exports data for migration.
  - **Example:**
    ```python
    nemo.MigManExportData()
    ```

---

### HubSpot Integration

- **`FetchDealFromHubSpotAndUploadToNEMO(projectname: str)`**
  - **Description:** Fetches deal data from HubSpot, processes it, and uploads the combined information to a specified NEMO project.
  - **Example:**
    ```python
    nemo.FetchDealFromHubSpotAndUploadToNEMO("ExampleProject")
    ```

---

### Attribute Groups

- **`getAttributeGroups(projectname: str)`**
  - **Description:** Fetches AttributeGroups metadata.
  - **Example:**
    ```python
    attribute_groups = nemo.getAttributeGroups("ExampleProject")
    print(attribute_groups)
    ```

- **`createAttributeGroups(projectname: str, attributegroups: list[AttributeGroup])`**
  - **Description:** Creates or updates a list of AttributeGroups.
  - **Example:**
    ```python
    nemo.createAttributeGroups("ExampleProject", attributegroups)
    ```

- **`deleteAttributeGroups(attributegroups: list[str])`**
  - **Description:** Deletes a list of AttributeGroups by their IDs.
  - **Example:**
    ```python
    nemo.deleteAttributeGroups(["AttributeGroup1", "AttributeGroup2"])
    ```

---

### Metrics

- **`getMetrics(projectname: str)`**
  - **Description:** Fetches Metrics metadata.
  - **Example:**
    ```python
    metrics = nemo.getMetrics("ExampleProject")
    print(metrics)
    ```

- **`createMetrics(projectname: str, metrics: list[Metric])`**
  - **Description:** Creates or updates a list of Metrics.
  - **Example:**
    ```python
    nemo.createMetrics("ExampleProject", metrics)
    ```

- **`deleteMetrics(metrics: list[str])`**
  - **Description:** Deletes a list of Metrics by their IDs.
  - **Example:**
    ```python
    nemo.deleteMetrics(["Metric1", "Metric2"])
    ```

---

### Tiles

- **`getTiles(projectname: str)`**
  - **Description:** Fetches Tiles metadata.
  - **Example:**
    ```python
    tiles = nemo.getTiles("ExampleProject")
    print(tiles)
    ```

- **`createTiles(projectname: str, tiles: list[Tile])`**
  - **Description:** Creates or updates a list of Tiles.
  - **Example:**
    ```python
    nemo.createTiles("ExampleProject", tiles)
    ```

- **`deleteTiles(tiles: list[str])`**
  - **Description:** Deletes a list of Tiles by their IDs.
  - **Example:**
    ```python
    nemo.deleteTiles(["Tile1", "Tile2"])
    ```

---

### Example Use Cases

- **Creating a New Project and Uploading Data**
  ```python
  nemo.createProjects([Project(name="Project A", description="Description")])
  nemo.ReUploadFile("Project A", "data.csv")
  ```

- **Fetching and Analyzing Project Data**
  ```python
  projects = nemo.getProjects()
  print(projects)
  ```

- **HubSpot Integration**
  ```python
  nemo.FetchDealFromHubSpotAndUploadToNEMO("Project B")
  ```

---

## Frequently Asked Questions (FAQ)

Answers to common questions about using the library.

