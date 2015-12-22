require 'xcodeproj'
path_to_project = "${SOURCE_ROOT}/${PROJECT_NAME}.xcodeproj"
project = Xcodeproj::Project.open(path_to_project)
# main_target = project.targets.first
# phase = main_target.new_shell_script_build_phase("Name of your Phase")
# phase.shell_script = "find ${SRCROOT} \( -name \"*.swift\" \) -print0 | \
# xargs -0 egrep --with-filename --line-number --only-matching \"WARN:*\$\" | \
# perl -p -e \"s/WARN:/ warning: \$1/\""
# project.save()

