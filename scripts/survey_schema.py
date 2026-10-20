"""Codes shared by the LimeSurvey builder and the database views.

LimeSurvey answer codes are limited to 5 alphanumeric characters, so the
surveys use short codes that are mapped here to the slugs used in the
repository CSV files. scripts/limesurvey_build.py writes this mapping to
sql/20_codes.sql. Change a code here and in delphi/limesurvey/texts.json
together, rebuild, and rerun sql/20_codes.sql in the database.
"""

LANGUAGES = ("pt-BR", "en")  # first one is the survey base language

# Q1 (geometry panel), question 1A1: field of work
AREA = {
    "MAT": "mathematics",
    "CGE": "computational-geometry",
    "GEO": "geodesy-cartography",
    "INT": "interval-analysis",
    "CS": "computer-science",
}

# Q2 (applications panel), question 2A1: user group (slugs as in delphi/protocol.md)
USER_GROUP = {
    "OST": "official-statistics",
    "CAD": "cadastre-registry",
    "RS": "remote-sensing",
    "ADL": "addressing-logistics",
    "HEM": "health-emergency",
    "ACA": "academia",
}

OTHER_GROUP = "other"  # answers given in the "Other" field of 1A1 / 2A1

INSTITUTION_Q1 = {"UNI": "university", "PUB": "public-agency", "COM": "company",
                  "INT": "international", "OTH": "other"}
INSTITUTION_Q2 = {"FED": "public-national", "STA": "public-state", "MUN": "public-municipal",
                  "UNI": "university", "COM": "company", "CSO": "civil-society",
                  "INT": "international", "OTH": "other"}
EXPERIENCE = {"E1": "<5", "E2": "5-10", "E3": "11-20", "E4": ">20"}
GRIDS_Q1 = ("ISO", "HEX", "QUAD", "TRI", "SFC", "NONE")
GRIDS_Q2 = ("STAT", "HEX", "QUAD", "GEOC", "NONE")

YES_NO = {"Y": "yes", "N": "no"}
DISCLOSURE = {"ANON": "anonymous", "NAMED": "named", "PUBL": "public"}
DISCLOSURE_ORDER = ("anonymous", "named", "public")  # most to least restrictive

FAMILIARITY = {"H": "high", "M": "medium", "L": "low"}
RELEVANCE = {"R0": 0, "R1": 1, "R2": 2, "R3": 3}
NESTING = {"Y": "yes", "N": "no", "U": "unknown"}

# Question codes
RID = "RID"            # hidden equation holding the pseudonymous code {TOKEN:ATTRIBUTE_1}
Q1_GROUP = "AREA"
Q2_GROUP = "UGRP"
GRADES = "GRD"         # Q1, array (numbers): property x geometry
GRADES_JUST = "GRDj"   # Q1, justification per property
NEST = "NEST"          # Q2, array: application -> Y/N/U
NEST_JUST = "NESTj"


def fam_code(app_id):
    return f"{app_id}fam"


def rel_code(app_id):
    return f"{app_id}rel"


def com_code(app_id):
    return f"{app_id}com"


# Open questions: LimeSurvey code -> questionnaire item number
OPEN_Q1 = {"OBJ": "1D1", "DEFS": "1E1", "NEWP": "1E2", "COMM": "1E3"}
OPEN_Q2 = {"NEWA": "2E1", "NEED": "2E2", "DEFA": "2E3", "COMM": "2E4"}
