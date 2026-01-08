Wait(5000)

-- CRUX.Notify(1,{
--     title = "UWU Cafe",
--     description = "Server Started Successfully",
--     type = "success",
--     duration = 3000,
-- })

-- Define table.count function at the top of the file
if not table.count then
    function table.count(tbl)
        local count = 0
        if tbl then
            for _ in pairs(tbl) do
                count = count + 1
            end
        end
        return count
    end
end

-- Event to handle menu items requests from clients
RegisterNetEvent(Config.ResourceName .. ':server:requestMenuItems')
AddEventHandler(Config.ResourceName .. ':server:requestMenuItems', function()
  local src = source
  local menuItems = {}

  -- Execute database query
  MySQL.query('SELECT * FROM ' .. tablePrefix .. 'menuItems', {}, function(result)
    if result and #result > 0 then
      menuItems = result
    end
    -- Send menu items back to the requesting client
    TriggerClientEvent(Config.ResourceName .. ':client:receiveMenuItems', src, menuItems)
  end)
end)

-- Event to update a menu item in the database
RegisterNetEvent(Config.ResourceName .. ':server:updateMenuItem')
AddEventHandler(Config.ResourceName .. ':server:updateMenuItem', function(data)
  local src = source

  -- Validate the data
  if not data or not data.id or not data.name or not data.label or not data.price then
    CRUX.Notify(src, {
      title = Config.Localess.BossMenu.menu_update,
      description = "Invalid data provided!",
      type = "error",
      duration = 5000,
    })
    return
  end

  -- Update the menu item in the database
  MySQL.update('UPDATE ' .. tablePrefix .. 'menuItems SET name = ?, label = ?, price = ?, image = ?, category = ?, categoryimage = ? WHERE id = ?',
    {data.name, data.label, data.price, data.image, data.category, data.categoryimage, data.id},
    function(rowsChanged)
      if rowsChanged > 0 then
        CRUX.Notify(src, {
          title = Config.Localess.BossMenu.menu_update,
          description = Config.Localess.BossMenu.menu_update_success,
          type = "success",
          duration = 5000,
        })
      else
        CRUX.Notify(src, {
          title = Config.Localess.BossMenu.menu_update,
          description = Config.Localess.BossMenu.menu_update_error,
          type = "error",
          duration = 5000,
        })
      end
    end
  )
end)

-- Event to delete a menu item from the database
RegisterNetEvent(Config.ResourceName .. ':server:deleteMenuItem')
AddEventHandler(Config.ResourceName .. ':server:deleteMenuItem', function(itemId)
  local src = source

  -- Delete the menu item from the database
  MySQL.update('DELETE FROM ' .. tablePrefix .. 'menuItems WHERE id = ?', {itemId},
    function(rowsChanged)
      if rowsChanged > 0 then
        CRUX.Notify(src, {
          title = Config.Localess.BossMenu.menu_delete,
          description = Config.Localess.BossMenu.menu_delete_success,
          type = "success",
          duration = 5000,
        })
      else
        CRUX.Notify(src, {
          title = Config.Localess.BossMenu.menu_delete,
          description = Config.Localess.BossMenu.menu_delete_error,
          type = "error",
          duration = 5000,
        })
      end
    end
  )
end)

-- Event to get nearby players (players in proximity of the source player)
RegisterNetEvent(Config.ResourceName .. ':server:getNearbyPlayers')
AddEventHandler(Config.ResourceName .. ':server:getNearbyPlayers', function()
  local src = source
  local players = {}

  -- Get source player's coordinates
  local srcPed = GetPlayerPed(src)
  local srcCoords = GetEntityCoords(srcPed)

  -- radius fallback
  local radius = tonumber(Config.NearbyPlayersRadius) or 10.0

  -- Get all players in the server except self
  for _, playerID in ipairs(GetPlayers()) do
    local playerIDNum = tonumber(playerID)
    if playerIDNum and playerIDNum ~= src then
      local playerPed = GetPlayerPed(playerIDNum)
      local playerCoords = GetEntityCoords(playerPed)

      -- Use vector distance calculation between GetEntityCoords results
      local distance = #(srcCoords - playerCoords)

      -- Check if within radius
      if distance <= radius then
        local playerName = CRUX.Framework.GetPlayerName(playerIDNum)
        if playerName then
          table.insert(players, {
            id = playerIDNum,
            name = playerName
          })
        end
      end
    end
  end

  -- Send nearby players to the client
  TriggerClientEvent(Config.ResourceName .. ':client:receiveNearbyPlayers', src, players)
end)

-- Event to get available job roles from config
RegisterNetEvent(Config.ResourceName .. ':server:getAvailableRoles')
AddEventHandler(Config.ResourceName .. ':server:getAvailableRoles', function()
  local src = source
  local roles = {}

  -- Query the database directly instead of using Config.Grades
  MySQL.query('SELECT * FROM ' .. tablePrefix .. 'job_grades WHERE job_name = ? ORDER BY grade ASC',
    {Config.JobName},
    function(result)
      if result and #result > 0 then
        -- Format the data for the client
        for _, gradeInfo in ipairs(result) do
          local roleId = string.lower(gradeInfo.label:gsub("%s+", ""))

          -- Add explicit debug info for the is_boss field
          Server.Debug("DEBUG: grade " .. gradeInfo.label .. " has is_boss value: " .. tostring(gradeInfo.is_boss) .. " (type: " .. type(gradeInfo.is_boss) .. ")")

          -- Correct boolean to number conversion - using Lua idiom
          local isBossValue = gradeInfo.is_boss and 1 or 0

          roles[roleId] = {
            id = roleId,
            gradeId = gradeInfo.grade,
            label = gradeInfo.label,
            salary = gradeInfo.salary,
            commission = gradeInfo.commission or 0,
            isBoss = isBossValue  -- Ensure it's a number (0 or 1)
          }

          -- Server.Debug debug info to validate the data
          Server.Debug(string.format("Sending grade data: %s (ID: %s, Grade: %d, Commission: %d, Salary: %d, Boss: %d)",
            gradeInfo.label,
            roleId,
            gradeInfo.grade,
            gradeInfo.commission or 0,
            gradeInfo.salary,
            isBossValue
          ))
        end
      else
        -- Fallback to Config if no database entries
        Server.Debug("No job grades found in database, using Config.Grades fallback")
        for gradeId, gradeInfo in pairs(Config.Grades) do
          local roleId = string.lower(gradeInfo.Label:gsub("%s+", ""))
          local isBossValue = gradeInfo.IsBoss and 1 or 0

          roles[roleId] = {
            label = gradeInfo.Label,
            salary = gradeInfo.Salary,
            commission = gradeInfo.Commission or 0,
            isBoss = isBossValue  -- Always send as numeric
          }

          Server.Debug(string.format("Sending config grade data: %s, Boss: %d",
            gradeInfo.Label,
            isBossValue
          ))
        end
      end

      -- Send available roles to the client
      TriggerClientEvent(Config.ResourceName .. ':client:receiveAvailableRoles', src, roles)
    end
  )
end)

-- New event to fetch actual job grades data directly from database
RegisterNetEvent(Config.ResourceName .. ':server:getJobGrades')
AddEventHandler(Config.ResourceName .. ':server:getJobGrades', function()
  local src = source

  -- Debug to check what job name we're querying for
  Server.Debug("Fetching job grades for job: " .. Config.JobName)

  MySQL.query('SELECT * FROM ' .. tablePrefix .. 'job_grades WHERE job_name = ? ORDER BY grade ASC',
    {Config.JobName},
    function(result)
      local grades = {}

      if result and #result > 0 then
        -- Format the data for the client
        Server.Debug("Found " .. #result .. " job grades in database")

        for _, grade in ipairs(result) do
          local roleId = string.lower(grade.label:gsub("%s+", ""))

          -- Add explicit debug info and ensure isBoss is numeric
          Server.Debug("DEBUG: grade " .. grade.label .. " has is_boss value: " .. tostring(grade.is_boss) .. " (type: " .. type(grade.is_boss) .. ")")

          -- Handle various possible formats for is_boss
          local isBossValue = 0
          if grade.is_boss == 1 or grade.is_boss == true or grade.is_boss == "1" then
            isBossValue = 1
          end

          grades[roleId] = {
            id = roleId,
            gradeId = grade.grade,
            label = grade.label,
            salary = grade.salary,
            commission = grade.commission or 0,
            isBoss = isBossValue  -- Always as a number (0 or 1)
          }

          Server.Debug(string.format("Sending grade data via getJobGrades: %s, Grade: %d, Boss: %d",
            grade.label,
            grade.grade,
            isBossValue
          ))
        end

        -- Make sure we have at least one row before sending
        if next(grades) ~= nil then
          -- Server.Debug out the full formatted data for verification
          Server.Debug("Full grades data being sent to client: " .. json.encode(grades))
          TriggerClientEvent(Config.ResourceName .. ':client:receiveJobGrades', src, grades)
          return
        end
      end

      -- Fallback to Config if no database entries
      Server.Debug("No job grades found in database, using Config.Grades fallback")
      for gradeId, gradeInfo in pairs(Config.Grades) do
        local roleId = string.lower(gradeInfo.Label:gsub("%s+", ""))
        local isBossValue = gradeInfo.IsBoss and 1 or 0

        grades[roleId] = {
          id = roleId,
          gradeId = tonumber(gradeId),
          label = gradeInfo.Label,
          salary = gradeInfo.Salary,
          commission = gradeInfo.Commission or 0,
          isBoss = isBossValue  -- Always send as numeric
        }

        Server.Debug(string.format("Sending config grade data: %s, Grade: %s, Boss: %d",
          gradeInfo.Label,
          gradeId,
          isBossValue
        ))
      end

      -- Send data even if using fallback
      if next(grades) ~= nil then
        Server.Debug("Full fallback grades data being sent to client: " .. json.encode(grades))
        TriggerClientEvent(Config.ResourceName .. ':client:receiveJobGrades', src, grades)
      else
        Server.Debug("WARNING: No job grades found in database or config")
        TriggerClientEvent(Config.ResourceName .. ':client:receiveJobGrades', src, {})
      end
    end
  )
end)

-- Initialize or get the business data
local function InitializeBusiness()
  MySQL.query('SELECT * FROM ' .. tablePrefix .. 'bossmenu WHERE id = ?', {Config.JobName}, function(result)
    if result and #result > 0 then
      -- Business already exists, no need to create
      Server.Debug('Business already exists in database: ' .. Config.JobName)
    else
      -- Create a new business entry
      MySQL.insert('INSERT INTO ' .. tablePrefix .. 'bossmenu (id, business_name, balance) VALUES (?, ?, ?)',
        {Config.JobName, Config.JobLabel, 0},
        function(id)
          if id then
            Server.Debug('Created new business: ' .. Config.JobLabel)
          else
            Server.Debug('Failed to create business')
          end
        end
      )
    end
  end)
end

-- Call initialization on resource start
Citizen.CreateThread(function()
  Wait(1000) -- Small delay to ensure database is ready
  InitializeBusiness()
end)

-- Add a table to track active invites with their sender IDs
local activeInvites = {}

-- Event to handle job invites
RegisterNetEvent(Config.ResourceName .. ':server:inviteEmployee')
AddEventHandler(Config.ResourceName .. ':server:inviteEmployee', function(playerId, roleId)
  local src = source
  local targetSrc = tonumber(playerId)

  -- Validate parameters
  if not targetSrc or not roleId then
    CRUX.Notify(src, {
      title = Config.Localess.BossMenu.invite_error,
      description = Config.Localess.BossMenu.invite_error,
      type = "error",
      duration = 5000,
    })
    return
  end

  -- Make sure the target player exists
  local targetName = CRUX.Framework.GetPlayerName(targetSrc)
  if not targetName then
    CRUX.Notify(src, {
      title = Config.Localess.BossMenu.invite_error,
      description = Config.Localess.BossMenu.player_not_found,
      type = "error",
      duration = 5000,
    })
    return
  end

  -- Convert roleId to lowercase and remove spaces to match our format
  local roleName = string.lower(roleId:gsub("%s+", ""))

  -- Get the role information from Config.Grades
  local roleInfo = nil
  for gradeId, gradeData in pairs(Config.Grades) do
    local configRoleId = string.lower(gradeData.Label:gsub("%s+", ""))
    if configRoleId == roleName then
      roleInfo = {
        grade = gradeId,
        label = gradeData.Label,
        salary = gradeData.Salary
      }
      break
    end
  end

  if not roleInfo then
    CRUX.Notify(src, {
      title = Config.Localess.BossMenu.invite_error,
      description = Config.Localess.System.invalid,
      type = "error",
      duration = 5000,
    })
    return
  end

  -- Get sender's name
  local senderName = CRUX.Framework.GetPlayerName(src)

  -- Generate a unique invite ID
  local inviteId = "invite_" .. math.random(100000, 999999)

  -- Store the sender's ID along with the invite
  activeInvites[inviteId] = src

  -- Send the job invitation to the target player
  TriggerClientEvent(Config.ResourceName .. ':client:receiveJobInvite', targetSrc, {
    id = inviteId,
    sender = senderName,
    jobName = Config.JobLabel,
    role = roleId,
    roleLabel = roleInfo.label,
    salary = roleInfo.salary,
    grade = roleInfo.grade
  })

  CRUX.Notify(src, {
    title = Config.Localess.BossMenu.invite_sent,
    description = string.format(Config.Localess.BossMenu.invite_sent_success, targetName),
    type = "success",
    duration = 5000,
  })
end)

-- Handle job invitation acceptance
RegisterNetEvent(Config.ResourceName .. ':server:acceptJobInvite')
AddEventHandler(Config.ResourceName .. ':server:acceptJobInvite', function(inviteData)
    local src = source

    -- Validate the invite data
    if not inviteData or not inviteData.role or not inviteData.grade then
        CRUX.Notify(src, {
          title = Config.Localess.System.error,
          description = Config.Localess.BossMenu.job_error,
          type = "error",
          duration = 5000,
        })
        return
    end

    -- Get player data
    local Player = CRUX.Framework.GetPlayer(src)
    if not Player then
        return
    end

    local playerName = CRUX.Framework.GetPlayerName(src)

    -- Simply use the framework's function to get the license
    local playerIdentifier = CRUX.Framework.GetIdentifier(src)

    -- Check if we got a valid identifier
    if not playerIdentifier then
        CRUX.Notify(src, {
          title = Config.Localess.System.error,
          description = Config.Localess.System.no_license,
          duration = 5000,
        })
        Server.Debug("ERROR: Could not determine license for player " .. playerName .. " (ID: " .. src .. ")")
        return
    end

    -- Set the player's job using our custom job system
    local success = JobSystem.SetJob(src, Config.JobName, tonumber(inviteData.grade))

    -- If job was set successfully, ensure they're on duty (optional based on Config)
    if success and Config.NeedDuty == false then
        JobSystem.SetJobDuty(src, true)
    end

    Server.Debug("Inserting employee with license: " .. playerIdentifier)

    -- Get commission rate based on grade
    local gradeLevel = tostring(inviteData.grade)
    local commission = 0
    if Config.Grades[gradeLevel] and Config.Grades[gradeLevel].Commission then
        commission = Config.Grades[gradeLevel].Commission
    end

    -- First, update or insert into user_jobs table
    MySQL.query('SELECT identifier FROM ' .. tablePrefix .. 'user_jobs WHERE identifier = ?', {playerIdentifier}, function(userJobResult)
        if userJobResult and #userJobResult > 0 then
            -- User exists in user_jobs, update their job
            MySQL.update('UPDATE ' .. tablePrefix .. 'user_jobs SET job = ?, grade = ? WHERE identifier = ?',
                {Config.JobName, tonumber(inviteData.grade), playerIdentifier},
                function(userJobRowsChanged)
                    if userJobRowsChanged > 0 then
                        Server.Debug("Updated user_jobs for: " .. playerName)
                    else
                        Server.Debug("Failed to update user_jobs for: " .. playerName)
                    end
                end
            )
        else
            -- User doesn't exist in user_jobs, insert new record
            MySQL.insert('INSERT INTO ' .. tablePrefix .. 'user_jobs (identifier, job, grade) VALUES (?, ?, ?)',
                {playerIdentifier, Config.JobName, tonumber(inviteData.grade)},
                function(userJobId)
                    if userJobId then
                        Server.Debug("Inserted new user_jobs record for: " .. playerName)
                    else
                        Server.Debug("Failed to insert user_jobs record for: " .. playerName)
                    end
                end
            )
        end
    end)

    -- Check if the employee already exists in employees table
    MySQL.query('SELECT license FROM ' .. tablePrefix .. 'employees WHERE license = ?', {playerIdentifier}, function(result)
        if result and #result > 0 then
          -- Employee exists, update their job_grade and job (no role or commission columns in table)
          MySQL.update('UPDATE ' .. tablePrefix .. 'employees SET job_grade = ?, job = ? WHERE license = ?',
            {tonumber(inviteData.grade), Config.JobName, playerIdentifier},
            function(rowsChanged)
              if rowsChanged > 0 then
                CRUX.Notify(src, {
                  title = Config.Localess.BossMenu.job_updated_title,
                  description = string.format(Config.Localess.BossMenu.job_updated, inviteData.roleLabel, Config.JobLabel),
                  type = "success",
                  duration = 5000,
                })

                -- NEW: Create employee data object for real-time update
                local newEmployeeData = {
                  license = playerIdentifier,
                  name = playerName,
                  role = inviteData.role,
                  job_grade = tonumber(inviteData.grade),
                  commission = commission,
                  job = Config.JobName,
                  experience = 0,
                  balance = 0,
                  delivery_balance = 0,
                  billing_balance = 0,
                  paycheck_balance = 0,
                  deliveries = 0,
                  billings = 0,
                  avatar = "/placeholder.svg?height=40&width=40",
                  isOnline = true
                }

                -- NEW: Notify all managers about the updated employee
                TriggerEvent(Config.ResourceName .. ':server:notifyEmployeeUpdate', newEmployeeData)
              else
                CRUX.Notify(src, {
                  title = Config.Localess.System.error,
                  description = Config.Localess.BossMenu.database_error,
                  type = "error",
                  duration = 5000,
                })
              end
            end
          )
        else
          -- Add the player to the employee database as a new employee
          MySQL.insert('INSERT INTO ' .. tablePrefix .. 'employees (license, name, job, job_grade, experience, balance, delivery_balance, billing_balance, paycheck_balance, deliveries, billings, notifications_enabled) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
            {playerIdentifier, playerName, Config.JobName, tonumber(inviteData.grade), 0, 0, 0, 0, 0, 0, 0, true},
            function(id)
              if id then
                CRUX.Notify(src, {
                  title = Config.Localess.BossMenu.job_updated_title,
                  description = string.format(Config.Localess.BossMenu.job_accepted, inviteData.roleLabel, Config.JobLabel),
                  type = "success",
                  duration = 5000,
                })

                -- NEW: Create employee data object for real-time update
                local newEmployeeData = {
                  license = playerIdentifier,
                  name = playerName,
                  role = inviteData.role,
                  job_grade = tonumber(inviteData.grade),
                  commission = commission,
                  job = Config.JobName,
                  experience = 0,
                  balance = 0,
                  delivery_balance = 0,
                  billing_balance = 0,
                  paycheck_balance = 0,
                  deliveries = 0,
                  billings = 0,
                  avatar = "/placeholder.svg?height=40&width=40",
                  isOnline = true
                }

                -- NEW: Notify all managers about the new employee
                TriggerEvent(Config.ResourceName .. ':server:notifyEmployeeUpdate', newEmployeeData)

                -- Notify all managers/bosses that a new employee has joined
                TriggerEvent(Config.ResourceName .. ':server:notifyManagers', playerName, inviteData.roleLabel)

                -- Notify the sender that their invite was accepted
                local inviterId = activeInvites[inviteData.id]
                if inviterId then
                    CRUX.Notify(inviterId, {
                        title = Config.Localess.BossMenu.invite_accepted_title or "Invite Accepted",
                        description = string.format(Config.Localess.BossMenu.invite_accepted_message or "%s has accepted your job invitation as %s.", playerName, inviteData.roleLabel),
                        type = "success",
                        duration = 5000
                    })

                    -- Remove the invite from tracking after it's been processed
                    activeInvites[inviteData.id] = nil
                end
              else
                CRUX.Notify(src, {
                  title = Config.Localess.System.error,
                  description = Config.Localess.BossMenu.database_error,
                  type = "error",
                  duration = 5000,
                })
              end
            end
          )
        end
    end)
end)

-- Handle job invitation rejection
RegisterNetEvent(Config.ResourceName .. ':server:rejectJobInvite')
AddEventHandler(Config.ResourceName .. ':server:rejectJobInvite', function(inviteData)
  local src = source

  -- Just notify the player
  CRUX.Notify(src, {
    title = Config.Localess.BossMenu.invite_rejected,
    description = Config.Localess.BossMenu.invite_rejected,
    type = "info",
    duration = 5000,
  })

  -- Clean up the tracking for this invite
  if inviteData and inviteData.id then
    activeInvites[inviteData.id] = nil
  end
end)

-- NEW: Add a notification event for real-time employee updates
RegisterNetEvent(Config.ResourceName .. ':server:notifyEmployeeUpdate')
AddEventHandler(Config.ResourceName .. ':server:notifyEmployeeUpdate', function(employeeData)
    -- Broadcast the new/updated employee to all clients
    TriggerClientEvent(Config.ResourceName .. ':client:newEmployeeAdded', -1, employeeData)
end)

-- Event to get business data
RegisterNetEvent(Config.ResourceName .. ':server:getBusinessData')
AddEventHandler(Config.ResourceName .. ':server:getBusinessData', function()
  local src = source
  local businessData = {}

  -- Query the database for business data
  MySQL.query('SELECT * FROM ' .. tablePrefix .. 'bossmenu WHERE id = ?', {Config.JobName}, function(result)
    if result and #result > 0 then
      -- Format the data in the way the UI expects it
      businessData = {
        name = result[1].business_name,
        balance = result[1].balance,
        inventoryCapacity = result[1].inventory_capacity or 75, -- Default value if not found
        dailyEarnings = result[1].daily_earnings or 0,
        employees = result[1].employees or 0,
        pendingOrders = result[1].pending_orders or 0,
        ongoingOrders = result[1].ongoing_orders or 0,
        completedOrders = result[1].completed_orders or 0
      }
    else
      -- Default values if no data found
      businessData = {
        name = Config.JobLabel,
        balance = 0,
        inventoryCapacity = 75,
        dailyEarnings = 0,
        employees = 0,
        pendingOrders = 0,
        ongoingOrders = 0,
        completedOrders = 0
      }
    end

    -- Send business data to the client
    TriggerClientEvent(Config.ResourceName .. ':client:receiveBusinessData', src, businessData)
  end)
end)

-- Event to handle withdrawals from the business account
RegisterNetEvent(Config.ResourceName .. ':server:withdrawMoney')
AddEventHandler(Config.ResourceName .. ':server:withdrawMoney', function(amount, withdrawMethod)
  local src = source
  local Player = CRUX.Framework.GetPlayer(src)
  withdrawMethod = withdrawMethod or 'cash' -- Default to cash if not specified

  if not Player then
    CRUX.Notify(src, {
      title = Config.Localess.BossMenu.withdraw_error,
      description = Config.Localess.BossMenu.player_not_found,
      type = "error",
      duration = 5000,
    })
    return
  end

  -- Validate amount
  amount = tonumber(amount)
  if not amount or amount <= 0 then
    CRUX.Notify(src, {
      title = Config.Localess.BossMenu.withdraw_error,
      description = Config.Localess.BossMenu.withdraw_error,
      type = "error",
      duration = 5000,
    })
    return
  end

  -- Check business balance
  MySQL.query('SELECT balance FROM ' .. tablePrefix .. 'bossmenu WHERE id = ?', {Config.JobName}, function(result)
    if not result or #result == 0 then
      CRUX.Notify(src, {
        title = Config.Localess.BossMenu.business_error,
        description = Config.Localess.BossMenu.business_error,
        type = "error",
        duration = 5000,
      })
      return
    end

    local businessBalance = tonumber(result[1].balance)
    if businessBalance < amount then
      CRUX.Notify(src, {
        title = Config.Localess.BossMenu.withdraw_error,
        description = Config.Localess.BossMenu.insufficient_funds or "Insufficient business funds.",
        type = "error",
        duration = 5000,
      })
      
      -- Notify all bosses about low balance
      local bosses = {}
      for _, playerId in ipairs(GetPlayers()) do
        local playerJob = JobSystem.GetJob(tonumber(playerId))
        if playerJob and playerJob.name == Config.JobName then
          local gradeLevel = tostring(playerJob.grade)
          if Config.Grades[gradeLevel] and Config.Grades[gradeLevel].IsBoss and tonumber(playerId) ~= src then
            table.insert(bosses, tonumber(playerId))
          end
        end
      end
      
      for _, bossId in ipairs(bosses) do
        CRUX.Notify(bossId, {
          title = Config.Localess.BossMenu.low_balance_alert or "⚠️ Low Balance Alert",
          description = string.format(Config.Localess.BossMenu.withdrawal_failed_message or "Withdrawal attempt failed. Business balance: $%s", businessBalance),
          type = "warning",
          duration = 7000
        })
      end
      
      return
    end

    -- Update business balance (withdrawal)
    MySQL.update('UPDATE ' .. tablePrefix .. 'bossmenu SET balance = balance - ? WHERE id = ? AND balance >= ?', {amount, Config.JobName, amount}, function(rowsChanged)
      if rowsChanged > 0 then
        -- Add money to player's account based on withdrawal method
          CRUX.Framework.AddMoney(src, withdrawMethod, amount)

        -- Notify the player
        CRUX.Notify(src, {
          title = Config.Localess.System.success,
          description = string.format(Config.Localess.BossMenu.money_withdrawn, amount),
          type = "success",
          duration = 5000,
        })

        -- Trigger client event to refresh money display
        TriggerClientEvent(Config.ResourceName .. ':client:updatePlayerMoney', src)

        -- Get updated business data
        MySQL.query('SELECT * FROM ' .. tablePrefix .. 'bossmenu WHERE id = ?', {Config.JobName}, function(result)
          if result and #result > 0 then
            -- Format the data in the way the UI expects it
            local updatedBusinessData = {
              name = result[1].business_name,
              balance = result[1].balance,
              inventoryCapacity = result[1].inventory_capacity or 75,
              dailyEarnings = result[1].daily_earnings or 0,
              employees = result[1].employees or 0,
              pendingOrders = result[1].pending_orders or 0,
              ongoingOrders = result[1].ongoing_orders or 0,
              completedOrders = result[1].completed_orders or 0
            }

            -- Send updated business data to the client
            TriggerClientEvent(Config.ResourceName .. ':client:updateBusinessData', src, updatedBusinessData)
          end
        end)
      else
        CRUX.Notify(src, {
          title = Config.Localess.System.error,
          description = Config.Localess.BossMenu.transaction_failed,
          type = "error",
          duration = 5000,
        })
      end
    end)
  end)
end)

-- Event to handle deposits to the business account
RegisterNetEvent(Config.ResourceName .. ':server:depositMoney')
AddEventHandler(Config.ResourceName .. ':server:depositMoney', function(amount, depositMethod)
  local src = source
  local Player = CRUX.Framework.GetPlayer(src)
  depositMethod = depositMethod or 'cash' -- Default to cash if not specified

  if not Player then
    CRUX.Notify(src, {
      title = Config.Localess.System.error,
      description = Config.Localess.BossMenu.player_not_found,
      type = "error",
      duration = 5000,
    })
    return
  end

  -- Validate amount
  amount = tonumber(amount)
  if not amount or amount <= 0 then
    CRUX.Notify(src, {
      title = Config.Localess.System.error,
      description = Config.Localess.BossMenu.withdraw_error,
      type = "error",
      duration = 5000,
    })
    return
  end

  -- Check player's balance based on deposit method
  local playerBalance = depositMethod == 'cash'
    and CRUX.Framework.GetMoney(src, 'cash')
    or CRUX.Framework.GetMoney(src, 'bank')

  if playerBalance < amount then
    CRUX.Notify(src, {
      title = Config.Localess.BossMenu.deposit_error,
      description = Config.Localess.BossMenu.insufficient_funds,
      type = "error",
      duration = 5000,
    })
    return
  end

  -- Remove money from player's account based on deposit method
  if depositMethod == 'cash' then
    CRUX.Framework.RemoveMoney(src, 'cash', amount)
    
    if CRUX.Society and CRUX.Society.AddTransaction then
        CRUX.Society.AddTransaction(
            Config.JobName,
            Config.JobName,
            CRUX.Framework.GetPlayerName(src),
            CRUX.Framework.GetIdentifier(src),
            amount,
            "Invoice Payment",
            src
        )
    end
    Server.Debug("Invoice Transaction Data:")
    Server.Debug("receiver_name:", Config.JobName)
    Server.Debug("receiver_identifier:", CRUX.Framework.GetIdentifier(src))
    Server.Debug("sender_name:", CRUX.Framework.GetPlayerName(src))
    Server.Debug("sender_identifier:", CRUX.Framework.GetIdentifier(src))
    Server.Debug("value:", amount)
    Server.Debug("reason:", "Invoice Payment")
    Server.Debug("targetId:", src)
  else
    CRUX.Framework.RemoveMoney(src, 'bank', amount)
    
    if CRUX.Society and CRUX.Society.AddTransaction then
        CRUX.Society.AddTransaction(
            Config.JobName,
            Config.JobName,
            CRUX.Framework.GetPlayerName(src),
            CRUX.Framework.GetIdentifier(src),
            amount,
            "Invoice Payment",
            src
        )
    end
    Server.Debug("Invoice Transaction Data:")
    Server.Debug("receiver_name:", Config.JobName)
    Server.Debug("receiver_identifier:", CRUX.Framework.GetIdentifier(src))
    Server.Debug("sender_name:", CRUX.Framework.GetPlayerName(src))
    Server.Debug("sender_identifier:", CRUX.Framework.GetIdentifier(src))
    Server.Debug("value:", amount)
    Server.Debug("reason:", "Invoice Payment")
    Server.Debug("targetId:", src)
  end

  -- Update business balance
  MySQL.update('UPDATE ' .. tablePrefix .. 'bossmenu SET balance = balance + ? WHERE id = ?', {amount, Config.JobName}, function(rowsChanged)
    if rowsChanged > 0 then
      -- Notify the player
      CRUX.Notify(src, {
        title = Config.Localess.System.success,
        description = string.format(Config.Localess.BossMenu.money_deposited, amount),
        type = "success",
        duration = 5000,
      })

      -- Trigger client event to refresh money display
      TriggerClientEvent(Config.ResourceName .. ':client:updatePlayerMoney', src)

      -- Get updated business data
      MySQL.query('SELECT * FROM ' .. tablePrefix .. 'bossmenu WHERE id = ?', {Config.JobName}, function(result)
        if result and #result > 0 then
          -- Format the data in the way the UI expects it
          local updatedBusinessData = {
            name = result[1].business_name,
            balance = result[1].balance,
            inventoryCapacity = result[1].inventory_capacity or 75,
            dailyEarnings = result[1].daily_earnings or 0,
            employees = result[1].employees or 0,
            pendingOrders = result[1].pending_orders or 0,
            ongoingOrders = result[1].ongoing_orders or 0,
            completedOrders = result[1].completed_orders or 0
          }

          -- Send updated business data to the client
          TriggerClientEvent(Config.ResourceName .. ':client:updateBusinessData', src, updatedBusinessData)
        end
      end)
    else
      -- If it failed, give the money back to the player based on deposit method
      CRUX.Framework.AddMoney(src, depositMethod, amount)

      CRUX.Notify(src, {
        title = Config.Localess.System.error,
        description = Config.Localess.BossMenu.transaction_failed_refund,
        type = "error",
        duration = 5000,
      })
    end
  end)
end)

-- Event to fetch employees from the database
-- RegisterNetEvent(Config.ResourceName .. ':server:getEmployees')
-- AddEventHandler(Config.ResourceName .. ':server:getEmployees', function()
--   local src = source

--   -- Query database for all employees for this job, joining with job_grades to get role, salary & commission
--   MySQL.query('SELECT e.*, g.name AS role_name, g.label AS grade_label, g.salary, g.commission FROM crux_employees e LEFT JOIN crux_job_grades g ON e.job = g.job_name AND e.job_grade = g.grade WHERE e.job = ? OR e.job IS NULL',
--     {Config.JobName}, function(result)
--     local employees = {}

--     if result and #result > 0 then
--       for i = 1, #result do
--         -- Format employee data for frontend, getting role/salary/commission from job_grades
--         table.insert(employees, {
--           license = result[i].license,
--           name = result[i].name,
--           balance = result[i].balance or 0,
--           role = result[i].role_name or "employee", -- Get role from job_grades
--           salary = result[i].salary or 0, -- Get salary from job_grades
--           commission = result[i].commission or 0, -- Get commission from job_grades
--           experience = result[i].experience or 0,
--           billings = result[i].billings or 0,
--           billing_balance = result[i].billing_balance or 0,
--           delivery_balance = result[i].delivery_balance or 0,
--           paycheck_balance = result[i].paycheck_balance or 0,
--           deliveries = result[i].deliveries or 0,
--           totalEarnings = result[i].balance or 0,
--           performance = result[i].performance or 0,
--           avatar = result[i].image or "/placeholder.svg?height=40&width=40"
--         })

--         -- Log the commission value for debugging
--         Server.Debug('Employee: ' .. result[i].name .. ', Commission from job grade: ' .. (result[i].commission or 0))
--       end

--       Server.Debug('Sending ' .. #employees .. ' employees to client')
--     else
--       Server.Debug('No employees found for ' .. Config.JobName)
--     end

--     -- Send employee data back to the requesting client
--     TriggerClientEvent(Config.ResourceName .. ':client:receiveEmployees', src, employees)
--   end)
-- end)

-- Add event to get player avatar
RegisterNetEvent(Config.ResourceName .. ':server:getPlayerAvatar')
AddEventHandler(Config.ResourceName .. ':server:getPlayerAvatar', function()
    local src = source
    local playerIdentifier = CRUX.Framework.GetIdentifier(src)

    -- Query for avatar from employee table
    MySQL.query('SELECT image FROM ' .. tablePrefix .. 'employees WHERE license = ? AND job = ? LIMIT 1',
        {playerIdentifier, Config.JobName},
        function(result)
            local avatarUrl = "/placeholder.svg?height=40&width=40" -- Default

            if result and #result > 0 and result[1].image then
                avatarUrl = result[1].image
                Server.Debug("Boss Menu: Found avatar for " .. GetPlayerName(src) .. ": " .. avatarUrl)
            else
                Server.Debug("Boss Menu: No avatar found for " .. GetPlayerName(src) .. ", using default")
            end

            -- Send the avatar URL to the client
            TriggerClientEvent(Config.ResourceName .. ':client:receivePlayerAvatar', src, avatarUrl)
        end
    )
end)

-- Add function to include avatar in employee data
local function GetEmployeesWithAvatars()
    local employees = {}

    local result = MySQL.query.await('SELECT e.*, g.name AS role_name, g.label AS grade_label, g.salary, g.commission FROM ' .. tablePrefix .. 'employees e LEFT JOIN ' .. tablePrefix .. 'job_grades g ON e.job = g.job_name AND e.job_grade = g.grade WHERE e.job = ?', {Config.JobName})

    if result and #result > 0 then
        for i = 1, #result do
            -- Compute canonical role id (match client availableRoles keys)
            local grade_label = result[i].grade_label or result[i].label or result[i].role_name
            local roleId = "employee"
            if grade_label then
                roleId = string.lower(tostring(grade_label):gsub("%s+", ""))
            elseif result[i].role_name then
                roleId = tostring(result[i].role_name)
            end

            table.insert(employees, {
                license = result[i].license,
                name = result[i].name,
                role = roleId,
                balance = result[i].balance or 0,
                salary = result[i].salary or 0,
                billings = result[i].billings or 0,
                billing_balance = result[i].billing_balance or 0,
                delivery_balance = result[i].delivery_balance or 0,
                paycheck_balance = result[i].paycheck_balance or 0,
                deliveries = result[i].deliveries or 0,
                experience = result[i].experience or 0,
                commission = result[i].commission or 0,
                performance = result[i].performance or 0,
                avatar = result[i].image or "/placeholder.svg?height=40&width=40"
            })
        end
    end

    return employees
end

-- Update the existing employee fetch event to include duty status

-- Update the existing employee fetch event to use the new function
RegisterNetEvent(Config.ResourceName .. ':server:getEmployees')
AddEventHandler(Config.ResourceName .. ':server:getEmployees', function()
    local src = source
    local employees = {}

    -- Query database for all employees for this job, joining with job_grades to get role, salary & commission
    MySQL.query('SELECT e.*, g.name AS role_name, g.label AS grade_label, g.salary, g.commission FROM ' .. tablePrefix .. 'employees e LEFT JOIN ' .. tablePrefix .. 'job_grades g ON e.job = g.job_name AND e.job_grade = g.grade WHERE e.job = ?',
        {Config.JobName}, function(result)

        if result and #result > 0 then
            for i = 1, #result do
                -- Get license
                local license = result[i].license

                -- Check if player is online
                local isOnline = false
                local isOnDuty = false

                -- Check each online player to find matches
                for _, playerId in ipairs(GetPlayers()) do
                    local playerIdentifier = CRUX.Framework.GetIdentifier(tonumber(playerId))
                    if playerIdentifier == license then
                        isOnline = true

                        -- Check duty status
                        local playerJob = JobSystem.GetJob(tonumber(playerId))
                        if playerJob and playerJob.onduty then
                            isOnDuty = true
                        end
                        break
                    end
                end

                -- Format employee data for frontend, compute canonical role id matching client keys
                local grade_label = result[i].grade_label or result[i].label or result[i].role_name
                local roleId = "employee"
                if grade_label then
                    roleId = string.lower(tostring(grade_label):gsub("%s+", ""))
                elseif result[i].role_name then
                    roleId = tostring(result[i].role_name)
                end

                table.insert(employees, {
                    license = license,
                    name = result[i].name,
                    balance = result[i].balance or 0,
                    role = roleId,
                    salary = result[i].salary or 0,
                    commission = result[i].commission or 0,
                    experience = result[i].experience or 0,
                    billings = result[i].billings or 0,
                    billing_balance = result[i].billing_balance or 0,
                    delivery_balance = result[i].delivery_balance or 0,
                    paycheck_balance = result[i].paycheck_balance or 0,
                    deliveries = result[i].deliveries or 0,
                    totalEarnings = result[i].balance or 0,
                    performance = result[i].performance or 0,
                    avatar = result[i].image or "/placeholder.svg?height=40&width=40",
                    isOnline = isOnline,
                    isOnDuty = isOnDuty
                })

                -- Log the commission value for debugging
                Server.Debug('Employee: ' .. result[i].name .. ', Commission from job grade: ' .. (result[i].commission or 0))
            end

            Server.Debug('Sending ' .. #employees .. ' employees to client')
        else
            Server.Debug('No employees found for ' .. Config.JobName)
        end

        -- Send employee data back to the requesting client
        TriggerClientEvent(Config.ResourceName .. ':client:receiveEmployees', src, employees)
    end)
end)

-- Add table to track online players and their license IDs
local onlineEmployees = {}

-- Function to get player identifier from source
local function GetPlayerIdentifier(source)
    return CRUX.Framework.GetIdentifier(source)
end

-- Track players when they connect
AddEventHandler('playerJoined', function()
    local src = source
    local identifier = GetPlayerIdentifier(src)

    if identifier then
        Server.Debug("Player connected with license: " .. identifier)
        onlineEmployees[identifier] = true

        -- Notify any open boss menus about the status change
        TriggerClientEvent(Config.ResourceName .. ':client:employeeStatusChanged', -1, {
            license = identifier,
            isOnline = true
        })
    end
end)

-- Track players when they disconnect
AddEventHandler('playerDropped', function()
    local src = source
    local identifier = GetPlayerIdentifier(src)

    if identifier and onlineEmployees[identifier] then
        Server.Debug("Player disconnected with license: " .. identifier)
        onlineEmployees[identifier] = nil

        -- Notify any open boss menus about the status change
        TriggerClientEvent(Config.ResourceName .. ':client:employeeStatusChanged', -1, {
            license = identifier,
            isOnline = false
        })
    end
end)

-- Initialize online employees when resource starts
Citizen.CreateThread(function()
    Wait(2000) -- Wait for server to fully initialize

    -- Get all current online players
    for _, playerId in ipairs(GetPlayers()) do
        local src = tonumber(playerId)
        local identifier = GetPlayerIdentifier(src)

        if identifier then
            onlineEmployees[identifier] = true
            Server.Debug("Found online player: " .. GetPlayerName(src) .. " with license: " .. identifier)
        end
    end

    if Server.DebugScript then
     Server.Debug("Initialized online employees tracking with " .. table.count(onlineEmployees) .. " players")
    end
end)

-- -- Modify the existing GetEmployeesWithAvatars function to include online status
-- local function GetEmployeesWithAvatars()
--     local employees = {}

--     local result = MySQL.query.await('SELECT e.*, g.name AS role_name, g.label AS grade_label, g.salary, g.commission FROM crux_employees e LEFT JOIN crux_job_grades g ON e.job = g.job_name AND e.job_grade = g.grade WHERE e.job = ?', {Config.JobName})

--     if result and #result > 0 then
--         for i = 1, #result do
--             -- Check if employee is online
--             local isOnline = onlineEmployees[result[i].license] or false

--             table.insert(employees, {
--                 license = result[i].license,
--                 name = result[i].name,
--                 role = result[i].role_name or "employee",
--                 balance = result[i].balance or 0,
--                 salary = result[i].salary or 0,
--                 billings = result[i].billings or 0,
--                 billing_balance = result[i].billing_balance or 0,
--                 delivery_balance = result[i].delivery_balance or 0,
--                 paycheck_balance = result[i].paycheck_balance or 0,
--                 deliveries = result[i].deliveries or 0,
--                 experience = result[i].experience or 0,
--                 commission = result[i].commission or 0,
--                 performance = result[i].performance or 0,
--                 avatar = result[i].image or "/placeholder.svg?height=40&width=40",
--                 isOnline = isOnline -- Add online status to employee data
--             })
--         end
--     end

--     return employees
-- end

-- Add a new event to check employee online status directly
RegisterNetEvent(Config.ResourceName .. ':server:checkEmployeeOnlineStatus')
AddEventHandler(Config.ResourceName .. ':server:checkEmployeeOnlineStatus', function(licenses)
    local src = source
    local statuses = {}

    if licenses and type(licenses) == 'table' then
        for _, license in ipairs(licenses) do
            statuses[license] = onlineEmployees[license] or false
        end
    end

    TriggerClientEvent(Config.ResourceName .. ':client:receiveEmployeeOnlineStatus', src, statuses)
end)

-- Event to get current player data including ID
RegisterNetEvent(Config.ResourceName .. ':server:getCurrentPlayerData')
AddEventHandler(Config.ResourceName .. ':server:getCurrentPlayerData', function()
  local src = source
  local playerName = CRUX.Framework.GetPlayerName(src)
  local playerIdentifier = CRUX.Framework.GetIdentifier(src)

  local playerData = {
    id = src,
    name = playerName,
    identifier = playerIdentifier,
    cash = CRUX.Framework.GetMoney(src, 'cash') or 0,
    bank = CRUX.Framework.GetMoney(src, 'bank') or 0
  }

  -- Send player data to the client
  TriggerClientEvent(Config.ResourceName .. ':client:receiveCurrentPlayerData', src, playerData)
end)


-- Handle employee updates (now just updating job_grade, not role or commission)
RegisterNetEvent(Config.ResourceName .. ':server:updateEmployee')
AddEventHandler(Config.ResourceName .. ':server:updateEmployee', function(data)
    local src = source

    -- Validate incoming data
    if not data or not data.employeeLicense then
        CRUX.Notify(src, {
            title = Config.Localess.System.error,
            description = "Invalid employee update data",
            type = "error",
            duration = 5000
        })
        TriggerClientEvent(Config.ResourceName .. ':client:updateEmployeeCallback', src, { success = false, description = "Invalid data" })
        return
    end

    -- Check permissions (keep existing permission check)

    -- Get job grade information if role has changed
    local job_grade = nil

    if data.role then
        -- Find the corresponding grade for this role
        for gradeId, gradeInfo in pairs(Config.Grades) do
            local roleId = string.lower(gradeInfo.Label:gsub("%s+", ""))
            if roleId == data.role then
                job_grade = tonumber(gradeId)
                break
            end
        end
    end

    -- If job_grade is found, only update that
    if job_grade then
        -- Update the job_grade - no more role or commission in employee table
        MySQL.update('UPDATE ' .. tablePrefix .. 'employees SET job_grade = ? WHERE license = ? AND job = ?',
            {job_grade, data.employeeLicense, Config.JobName},
            function(affectedRows)
                if affectedRows > 0 then

                    -- After update, fetch the latest employee data with job grade info
                    MySQL.query('SELECT e.*, g.label as grade_label, g.name as role_name, g.commission, g.salary FROM ' .. tablePrefix .. 'employees e LEFT JOIN ' .. tablePrefix .. 'job_grades g ON e.job = g.job_name AND e.job_grade = g.grade WHERE e.license = ? AND e.job = ?',
                        {data.employeeLicense, Config.JobName},
                        function(result)
                            if result and #result > 0 then
                                -- Send updated employee data to refresh the UI with grade info
                                local grade_label = result[1].grade_label or result[1].label or result[1].role_name
                                local roleId = "employee"
                                if grade_label then
                                    roleId = string.lower(tostring(grade_label):gsub("%s+", ""))
                                elseif result[1].role_name then
                                    roleId = tostring(result[1].role_name)
                                end
                                
                                TriggerClientEvent(Config.ResourceName .. ':client:employeeUpdated', src, {
                                    license = data.employeeLicense,
                                    commission = result[1].commission or 0,
                                    role = roleId,
                                    salary = result[1].salary or 0,
                                    job_grade = result[1].job_grade,
                                    grade_label = result[1].grade_label
                                })
                            end
                        end
                    )
                end
            end)
            JobSystem.SetJob(src, Config.JobName, job_grade)
    else
        CRUX.Notify(src, {
            title = Config.Localess.System.error,
            description = "Could not determine job grade from role",
            type = "error",
            duration = 5000
        })
    end
end)

-- Event to get transactions from the database
RegisterNetEvent(Config.ResourceName .. ':server:getTransactions')
AddEventHandler(Config.ResourceName .. ':server:getTransactions', function()
  local src = source

  -- Query database for transactions
  MySQL.query('SELECT * FROM ' .. tablePrefix .. 'transactions WHERE job = ? ORDER BY created_at DESC LIMIT 100',
    {Config.JobName},
    function(result)
      if result and #result > 0 then
        -- Send transactions back to the client
        TriggerClientEvent(Config.ResourceName .. ':client:receiveTransactions', src, result)
      else
        -- Send empty array if no transactions found
        TriggerClientEvent(Config.ResourceName .. ':client:receiveTransactions', src, {})
      end
    end
  )
end)

-- Add handler for getting paycheck history
RegisterNetEvent(Config.ResourceName .. ':server:getPaycheckHistory')
AddEventHandler(Config.ResourceName .. ':server:getPaycheckHistory', function()
    local src = source

    -- Get paycheck history for this business
    MySQL.query('SELECT p.*, j.label as grade_label FROM ' .. tablePrefix .. 'paycheck_history p LEFT JOIN ' .. tablePrefix .. 'job_grades j ON p.job = j.job_name AND p.job_grade = j.grade WHERE p.job = ? ORDER BY p.created_at DESC LIMIT 50',
        {Config.JobName},
        function(result)
            if result then
                TriggerClientEvent(Config.ResourceName .. ':client:updatePaycheckHistory', src, {paychecks = result})
            else
                TriggerClientEvent(Config.ResourceName .. ':client:updatePaycheckHistory', src, {paychecks = {}})
            end
        end
    )
end)

-- Track who is using the boss menu
local bossMenuStatus = {
    inUse = false,
    userId = nil,
    userName = nil,
    lastAccessed = 0
}

-- Function to check if the boss menu is available
-- Auto-releases if the last access was more than 5 minutes ago
local function IsBossMenuAvailable()
    local currentTime = os.time()

    -- Auto-release after 5 minutes of inactivity
    if bossMenuStatus.inUse and bossMenuStatus.lastAccessed > 0 and (currentTime - bossMenuStatus.lastAccessed) > 300 then
        Server.Debug("Auto-releasing boss menu - inactive for more than 5 minutes")
        bossMenuStatus.inUse = false
        bossMenuStatus.userId = nil
        bossMenuStatus.userName = nil
        bossMenuStatus.lastAccessed = 0
    end

    return not bossMenuStatus.inUse
end

-- Register event to check boss menu availability
RegisterNetEvent(Config.ResourceName .. ':server:checkBossMenuAvailability')
AddEventHandler(Config.ResourceName .. ':server:checkBossMenuAvailability', function()
    local src = source
    local available = IsBossMenuAvailable()
    local userName = bossMenuStatus.userName or "Another manager"

    TriggerClientEvent(Config.ResourceName .. ':client:bossMenuAvailability', src, {
        available = available,
        userName = userName
    })
end)

-- Register event to claim boss menu
RegisterNetEvent(Config.ResourceName .. ':server:claimBossMenu')
AddEventHandler(Config.ResourceName .. ':server:claimBossMenu', function()
    local src = source
    local playerName = CRUX.Framework.GetPlayerName(src)

    -- Allow re-claim by the same user to fix rapid opening issues
    if IsBossMenuAvailable() or (bossMenuStatus.inUse and bossMenuStatus.userId == src) then
        bossMenuStatus.inUse = true
        bossMenuStatus.userId = src
        bossMenuStatus.userName = playerName
        bossMenuStatus.lastAccessed = os.time()

        TriggerClientEvent(Config.ResourceName .. ':client:bossMenuAvailability', src, {
            available = true,
            userName = playerName
        })

        Server.Debug("Boss menu claimed by " .. playerName .. " (ID: " .. src .. ")")
    else
        TriggerClientEvent(Config.ResourceName .. ':client:bossMenuAvailability', src, {
            available = false,
            userName = bossMenuStatus.userName or "Another manager"
        })

        Server.Debug("Boss menu access denied for " .. playerName .. " (ID: " .. src .. "), already in use by " .. (bossMenuStatus.userName or "Unknown"))
    end
end)

-- Register event to release boss menu
RegisterNetEvent(Config.ResourceName .. ':server:releaseBossMenu')
AddEventHandler(Config.ResourceName .. ':server:releaseBossMenu', function()
    local src = source

    -- Only release if this player is the one who claimed it
    if bossMenuStatus.inUse and bossMenuStatus.userId == src then
        local playerName = bossMenuStatus.userName or "Unknown"

        bossMenuStatus.inUse = false
        bossMenuStatus.userId = nil
        bossMenuStatus.userName = nil
        bossMenuStatus.lastAccessed = 0

        Server.Debug("Boss menu released by " .. playerName .. " (ID: " .. src .. ")")
    end
end)

-- Clean up if player disconnects while using boss menu
AddEventHandler('playerDropped', function()
    local src = source

    if bossMenuStatus.inUse and bossMenuStatus.userId == src then
        bossMenuStatus.inUse = false
        bossMenuStatus.userId = nil
        bossMenuStatus.userName = nil
        bossMenuStatus.lastAccessed = 0

        Server.Debug("Boss menu released - player disconnected (ID: " .. src .. ")")
    end
end)

-- Update last accessed timestamp when specific boss menu actions are performed
local function UpdateBossMenuActivity(src)
    if bossMenuStatus.inUse and bossMenuStatus.userId == src then
        bossMenuStatus.lastAccessed = os.time()
    end
end

-- Update existing event handlers to refresh activity timestamp
local originalHandlers = {
    [Config.ResourceName .. ':server:withdrawMoney'] = true,
    [Config.ResourceName .. ':server:depositMoney'] = true,
    [Config.ResourceName .. ':server:updateMenuItem'] = true,
    [Config.ResourceName .. ':server:deleteMenuItem'] = true,
    [Config.ResourceName .. ':server:inviteEmployee'] = true,
    [Config.ResourceName .. ':server:updateEmployee'] = true,
    [Config.ResourceName .. ':server:fireEmployee'] = true,
    [Config.ResourceName .. ':server:toggleBusinessStatus'] = true
}

for eventName, _ in pairs(originalHandlers) do
    local originalHandler = AddEventHandler(eventName, function() end)
    RemoveEventHandler(originalHandler)

    AddEventHandler(eventName, function(...)
        UpdateBossMenuActivity(source)
        -- Original handler will still be called
    end)
end

-- Event to handle vending machine items requests from clients
RegisterNetEvent(Config.ResourceName .. ':server:requestVendingMachineItems')
AddEventHandler(Config.ResourceName .. ':server:requestVendingMachineItems', function()
  local src = source
  local vendingMachineItems = {}

  -- Execute database query
  MySQL.query('SELECT * FROM ' .. tablePrefix .. 'vendingMachineItems', {}, function(result)
    if result and #result > 0 then
      vendingMachineItems = result
    end
    -- Send vending machine items back to the requesting client
    TriggerClientEvent(Config.ResourceName .. ':client:receiveVendingMachineItems', src, vendingMachineItems)
  end)
end)

-- Event to update a vending machine item in the database
RegisterNetEvent(Config.ResourceName .. ':server:updateVendingMachineItem')
AddEventHandler(Config.ResourceName .. ':server:updateVendingMachineItem', function(data)
  local src = source

  -- Validate the data
  if not data or not data.id or not data.name or not data.label or not data.price then
    CRUX.Notify(src, {
      title = Config.Localess.BossMenu.vending_update,
      description = Config.Localess.BossMenu.vending_update_success,
      type = "error",
      duration = 5000,
    })
    return
  end

  -- Update the vending machine item in the database
  MySQL.update('UPDATE ' .. tablePrefix .. 'vendingMachineItems SET name = ?, label = ?, price = ?, image = ?, category = ? WHERE id = ?',
    {data.name, data.label, data.price, data.image, data.category, data.id},
    function(rowsChanged)
      if rowsChanged > 0 then
        CRUX.Notify(src, {
          title = Config.Localess.BossMenu.vending_update,
          description = Config.Localess.BossMenu.vending_update_success,
          type = "success",
          duration = 5000,
        })
      else
        CRUX.Notify(src, {
          title = Config.Localess.BossMenu.vending_update,
          description = Config.Localess.BossMenu.vending_update_error,
          type = "error",
          duration = 5000,
        })
      end
    end
  )
end)

-- Event to delete a vending machine item from the database
RegisterNetEvent(Config.ResourceName .. ':server:deleteVendingMachineItem')
AddEventHandler(Config.ResourceName .. ':server:deleteVendingMachineItem', function(itemId)
  local src = source

  -- Delete the vending machine item from the database
  MySQL.update('DELETE FROM ' .. tablePrefix .. 'vendingMachineItems WHERE id = ?', {itemId},
    function(rowsChanged)
      if rowsChanged > 0 then
        CRUX.Notify(src, {
          title = Config.Localess.BossMenu.vending_delete,
          description = Config.Localess.BossMenu.vending_delete_success,
          type = "success",
          duration = 5000,
        })
      else
        CRUX.Notify(src, {
          title = Config.Localess.BossMenu.vending_delete,
          description = Config.Localess.BossMenu.vending_delete_error,
          type = "error",
          duration = 5000,
        })
      end
    end)
end)

