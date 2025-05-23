import json
from pathlib import Path
from typing import Any, List, Type, TypeVar, get_type_hints
from nemo_library.model.application import Application
from nemo_library.model.attribute_group import AttributeGroup
from nemo_library.model.defined_column import DefinedColumn
from nemo_library.model.metric import Metric
from nemo_library.model.pages import Page
from nemo_library.model.attribute_link import AttributeLink
from nemo_library.model.diagram import Diagram
from nemo_library.model.report import Report
from nemo_library.model.rule import Rule
from nemo_library.model.subprocess import SubProcess
from nemo_library.model.tile import Tile

T = TypeVar("T")

ROOT = "optimate"
VARIANTS = ["purchasing", "sales"]
METRIC_FIELDS = {
    "purchasing": {
        "dateColumn": "pur_order_doc_date",
        "groupByColumn": "pur_order_doc_i_d",
    },
    "sales": {
        "dateColumn": "invoice_doc_date",
        "groupByColumn": "invoice_doc_i_d",
    },
}


def _load_data_from_json(file: str, cls: Type[T]) -> List[T]:
    """
    Loads JSON data from a file and converts it into a list of DataClass instances,
    handling nested structures recursively.
    """
    path = Path(".") / f"metadata_{ROOT}" / f"{file}.json"
    with open(path, "r", encoding="utf-8") as f:
        data = json.load(f)

    return [_deserializeMetaDataObject(item, cls) for item in data]


def _deserializeMetaDataObject(value: Any, target_type: Type) -> Any:
    """
    Recursively deserializes JSON data into a nested DataClass structure.
    """
    if isinstance(value, list):
        # Check if we expect a list of DataClasses
        if hasattr(target_type, "__origin__") and target_type.__origin__ is list:
            element_type = target_type.__args__[0]
            return [_deserializeMetaDataObject(v, element_type) for v in value]
        return value  # Regular list without DataClasses
    elif isinstance(value, dict):
        # Check if the target type is a DataClass
        if hasattr(target_type, "__annotations__"):
            field_types = get_type_hints(target_type)
            return target_type(
                **{
                    key: _deserializeMetaDataObject(value[key], field_types[key])
                    for key in value
                    if key in field_types
                }
            )
        return value  # Regular dictionary
    return value  # Primitive values


def _generic_test(items):
    internal_names = [item.internalName for item in items]
    # check if all internal names are unique
    duplicates = set([name for name in internal_names if internal_names.count(name) > 1])
    assert len(internal_names) == len(
        set(internal_names)
    ), f"found duplicate internal names: {duplicates}"
    
    for item in items:

        # every item must have an internal name starting with ROOT
        assert item.internalName.startswith(
            ROOT
        ), f"internal name of item does not start with {ROOT}: {item.internalName}"

        # every item (except attribut links and the ROOT item itself) must have a variant
        if item.internalName != ROOT and not isinstance(item, AttributeLink):
            assert (
                item.internalName.count("_") >= 1
            ), f"internal name of item does not contain any underscore: {item.internalName}"
            assert (
                item.internalName.split("_")[1] in VARIANTS
            ), f"internal name of item does not contain a valid variant: {item.internalName}"
        assert (
            "en" in item.displayNameTranslations
        ), f"displayNameTranslations of item does not contain 'en': item {item.internalName}"
        assert (
            "de" in item.displayNameTranslations
        ), f"displayNameTranslations of item does not contain 'de': item {item.internalName}"

        assert (
            item.displayName == item.displayNameTranslations["en"]
        ), f"displayName is not equal to displayNameTranslations['en']: {item.internalName}"


def test_applications():
    _generic_test(applications)


def test_attributegroups():
    _generic_test(attributegroups)


def test_attributelinks():
    _generic_test(attributelinks)


def test_definedcolumns():
    _generic_test(definedcolumns)

    # check if all defined columns are used in a metric
    for definedcolumn in definedcolumns:
        found = False
        for metric in metrics:
            if definedcolumn.internalName in metric.aggregateBy:
                found = True
                break
            if definedcolumn.internalName in metric.aggregateFunction:
                found = True
                break
            if definedcolumn.internalName in metric.groupByAggregations.keys():
                found = True
                break

        # or in another defined column
        for definedcolumn2 in definedcolumns:
            if definedcolumn.internalName in definedcolumn2.formula:
                found = True
                break

        assert (
            found
        ), f"defined column {definedcolumn.internalName} is not used in a metric nor another defined column"


def test_diagrams():
    _generic_test(diagrams)


def test_metrics():
    _generic_test(metrics)

    # Check internal names
    for metric in metrics:

        app = metric.internalName.split("_")[
            1
        ]  # we have ensured in _generic_tests, that this split will work
        if metric.dateColumn != METRIC_FIELDS[app]["dateColumn"]:
            assert (
                False
            ), f"found {app} metric that does not have {METRIC_FIELDS[app]["dateColumn"]} as date column: {metric.internalName}"
        if metric.groupByColumn != METRIC_FIELDS[app]["groupByColumn"]:
            assert (
                False
            ), f"found {app} metric that does not have {METRIC_FIELDS[app]["groupByColumn"]} as groupByColumn column: {metric.internalName}"

    # Check if all metrics are part of a diagram
    metrics_in_diagrams = [
        values.column for diagram in diagrams for values in diagram.values
    ]
    for metric in metrics:
        if metric.internalName not in metrics_in_diagrams:
            assert (
                False
            ), f"found metric that is not part of a diagram: {metric.internalName}"


def test_pages():
    _generic_test(pages)


def test_reports():
    _generic_test(reports)


def test_rules():
    _generic_test(rules)


def test_subprocesses():
    _generic_test(subprocesses)


def test_tiles():
    _generic_test(tiles)


applications = _load_data_from_json("applications", Application)
attributegroups = _load_data_from_json("attributegroups", AttributeGroup)
attributelinks = _load_data_from_json("attributelinks", AttributeLink)
definedcolumns = _load_data_from_json("definedcolumns", DefinedColumn)
diagrams = _load_data_from_json("diagrams", Diagram)
metrics = _load_data_from_json("metrics", Metric)
pages = _load_data_from_json("pages", Page)
reports = _load_data_from_json("reports", Report)
rules = _load_data_from_json("rules", Rule)
subprocesses = _load_data_from_json("subprocesses", SubProcess)
tiles = _load_data_from_json("tiles", Tile)
