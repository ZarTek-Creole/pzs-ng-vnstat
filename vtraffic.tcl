#################################################################################
# vTraffic Plug-in for pzs-ng                                                   #
# Author: ZarTek-Creole                                                         #
# GitHub: https://github.com/ZarTek-Creole/pzs-ng-vnstat                        #
#################################################################################
#
# Description:
# - Displays a summary of bandwidth statistics from vnstat for a given period.
# - The plugin allows IRC users to retrieve traffic statistics based on the 
#   selected period, with a default period of "day".
# 
# Installation:
# 1. Copy this file (vtraffic.tcl) into your pzs-ng sitebot 'plugins' folder.
# 2. Add the following line to your eggdrop.conf:
#    source pzs-ng/plugins/vtraffic.tcl
# 3. Rehash or restart your eggdrop for the changes to take effect.
#
# Usage:
# - The command to use this plugin is: !vtraffic <period>
# - Default period is "day", but you can specify "hour", "month", etc.
#
#################################################################################

# All plugins should reside in the ::ngBot::plugin::vtraffic namespace!
namespace eval ::ngBot::plugin::vtraffic {
    # Short hand for ::ngBot::plugin::vtraffic
    variable ns [namespace current]
    # Short hand for ::ngBot
    variable np [namespace qualifiers [namespace parent]]

    # Initialize the plugin
    proc init {} {
        variable ns
        variable np

        # Register the event handler for the !vtraffic command
        pzs-ng register_command vtraffic !vtraffic handle_vtraffic
    }

    # Function to retrieve and format vnstat data for the given period
    proc get_vnstat {periode} {
        # If no period is specified, default to "day"
        if {[string length $periode] == 0} {
            set periode "day"
        }

        # Execute the vnstat command for the given period
        set command "vnstat -$periode"
        set result [exec $command]

        # Format the result to be more readable on IRC
        return "[Traffic $periode] - $result"
    }

    # Handler for the !vtraffic command
    proc handle_vtraffic {nick host args} {
        # Get the period from the arguments, defaulting to "day"
        set periode [lindex $args 0]
        set stats [get_vnstat $periode]

        # Send the formatted stats to the IRC user
        pzs-ng sendmsg $nick $stats
    }

    # Deinitialize the plugin (cleanup)
    proc deinit {} {
        variable ns
        variable np

        # Unregister the event handler for the !vtraffic command
        pzs-ng unregister_command vtraffic !vtraffic handle_vtraffic

        # Remove the namespace
        namespace delete $ns
    }
}

# Initialize the plugin when sourced
::ngBot::plugin::vtraffic::init
