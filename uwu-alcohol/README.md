

Act as a strict code localization expert. I need you to translate the Lua code block below from English into(e.g., ar, da, cz, ge,id,it,ja,ko,mn,pl,ru,sv,tr,vi,yue)

You must follow these strict technical rules:

NO SKIPPING: You must output the entire file line-by-line. Do not summarize, do not use placeholders like ... rest of code ..., and do not shorten the file. I need the full, executable code.

Structure: Do not change any variable names, table keys (the text on the left side of the = sign), or the Lua syntax.

Translation: Only translate the string values (the text inside the quotation marks on the right side of the = sign).

Formatting Variables: You must preserve all formatting placeholders (like %s, %d, %s%%) exactly as they appear in the original string. Do not move or translate them.

Locale Key: At the top of the file, change Locales["en"] to the appropriate language code for the target language. For the requested languages, replace "en" with one of these codes:

Locales["ar"]
Locales["da"]
Locales["cz"]
Locales["ge"] 
Locales["id"]
Locales["it"]
Locales["ja"]
Locales["ko"]
Locales["mn"]
Locales["pl"]
Locales["ru"]
Locales["sv"]
Locales["tr"]
Locales["vi"]
Locales["yue"]

Example: change
Locales["en"] = { ... }
to
Locales["ar"] = { ... }

Comments: Leave the code comments (lines starting with --) in English to preserve developer context, or strictly translate them only if they are player-facing instructions.



# REST Resource Exports

This resource provides various exports for managing jobs, duty status, experience, and zones in your FiveM server.

## Server Side Exports

### hasJob(playerId)
Checks if a player has a job.
- **Parameters**: `playerId` (number) - The player's server ID.
- **Returns**: `boolean` - True if the player has a job, false otherwise.
- **Example**:
  ```lua
  local hasJob = exports.rest:hasJob(1)  -- Returns true/false
  if hasJob then
      print("Player has a job")
  end
  ```

### getJob(playerId)
Retrieves the job details of a player.
- **Parameters**: `playerId` (number) - The player's server ID.
- **Returns**: `table` or `false` - The job data if the player has a job, false otherwise.
- **Example**:
  ```lua
  local Job = exports.rest:getJob(1)  -- Returns job table or false
  if Job then
      print(json.encode(Job))
  end
  ```

### onDuty(playerId)
Checks if a player is on duty.
- **Parameters**: `playerId` (number) - The player's server ID.
- **Returns**: `boolean` - True if the player is on duty, false otherwise.
- **Example**:
  ```lua
  local onDuty = exports.rest:onDuty(1)  -- Returns true/false
  if onDuty then
      print("Player is on duty")
  end
  ```

### hasJobAndGrade(playerId, grade)
Checks if a player has a specific job and grade.
- **Parameters**: 
  - `playerId` (number) - The player's server ID.
  - `grade` (number) - The desired grade level.
- **Returns**: `boolean` - True if the player has the job and grade, false otherwise.
- **Example**:
  ```lua
  local hasJobAndGrade = exports.rest:hasJobAndGrade(1, 5)  -- Replace 5 with desired grade
  if hasJobAndGrade then
      print("Player has the job and grade 5")
  end
  ```

### getPlayerExperience(playerId)
Retrieves the experience points of a player.
- **Parameters**: `playerId` (number) - The player's server ID.
- **Returns**: `number` or `nil` - The player's XP if available, nil otherwise.
- **Example**:
  ```lua
  local xp = exports.rest:getPlayerExperience(1)
  if xp then
      print("Player XP: " .. tostring(xp))
  end
  ```

## Client Side Exports

### hasJob()
Checks if the local player has a job.
- **Returns**: `boolean` - True if the player has a job, false otherwise.
- **Example**:
  ```lua
  local hasJob = exports.rest:hasJob()  -- Returns true/false
  if hasJob then
      print("Player has a job")
  end
  ```

### getJob()
Retrieves the job details of the local player.
- **Returns**: `table` or `false` - The job data if the player has a job, false otherwise.
- **Example**:
  ```lua
  local Job = exports.rest:getJob()  -- Returns job table or false
  if Job then
      print(json.encode(Job))
  end
  ```

### onDuty()
Checks if the local player is on duty.
- **Returns**: `boolean` - True if the player is on duty, false otherwise.
- **Example**:
  ```lua
  local onDuty = exports.rest:onDuty()  -- Returns true/false
  if onDuty then
      print("Player is on duty")
  end
  ```

### hasJobAndGrade(grade)
Checks if the local player has a specific grade.
- **Parameters**: `grade` (number) - The desired grade level.
- **Returns**: `boolean` - True if the player has the grade, false otherwise.


- **Example**:
  ```lua
  local hasJobAndGrade = exports.rest:hasJobAndGrade(5)  -- Replace 5 with desired grade
  if hasJobAndGrade then
      print("Player has the job and grade 5")
  end
  ```

### insideZone()
Checks if the local player is inside a zone.
- **Returns**: `boolean` - True if the player is inside a zone, false otherwise.
- **Example**:
  ```lua
  local inside = exports.rest:insideZone()
  if inside then
      print("Player is inside a zone")
  end
  ```




