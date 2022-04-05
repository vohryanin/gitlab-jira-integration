def key = issue.key

def field = issue.fields

def cfINeed = "customfield_12853"

// hold field value
def my_value

def result = get("/rest/api/2/issue/${key}")
        .header('Content-Type', 'application/json')
        .asObject(Map)

if (result.status < 300) {
    logger.info("Success getting fields")
// field value
    my_value = field[cfINeed]
} else {
    logger.info("Error getting fields")
}