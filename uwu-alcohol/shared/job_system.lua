JobSystem = {}

-- Define job grades structure based on the existing config
JobSystem.Grades = {}

-- Function to be called on resource start to initialize grades from Config
function JobSystem.InitializeGrades()
    -- Copy grades from existing config
    for jobName, jobConfig in pairs(Config) do
        if jobName == "JobName" or jobName == "JobLabel" then
            -- These are just string values, not job configurations
            goto continue
        end

        if type(jobConfig) == "table" and jobConfig.Grades then
            JobSystem.Grades[jobConfig] = {}
            for gradeId, gradeInfo in pairs(jobConfig.Grades) do
                JobSystem.Grades[jobConfig][gradeId] = {
                    Label = gradeInfo.Label,
                    Salary = gradeInfo.Salary,
                    IsBoss = gradeInfo.IsBoss or false,
                    Commission = gradeInfo.Commission or 0
                }
            end
        end

        ::continue::
    end

    -- Always ensure the Config.JobName has grades from Config.Grades
    JobSystem.Grades[Config.JobName] = Config.Grades
end
