# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_stars_global_optspecs
	string join \n C/config-file= h/help V/version
end

function __fish_stars_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_stars_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_stars_using_subcommand
	set -l cmd (__fish_stars_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c stars -n "__fish_stars_needs_command" -s C -l config-file -d 'file to look for other command line args in' -r -F
complete -c stars -n "__fish_stars_needs_command" -s h -l help -d 'Print help'
complete -c stars -n "__fish_stars_needs_command" -s V -l version -d 'Print version'
complete -c stars -n "__fish_stars_needs_command" -f -a "projections"
complete -c stars -n "__fish_stars_needs_command" -f -a "stars"
complete -c stars -n "__fish_stars_needs_command" -f -a "completions"
complete -c stars -n "__fish_stars_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c stars -n "__fish_stars_using_subcommand projections" -l star-shape -d 'symbol to use for star in terminal' -r
complete -c stars -n "__fish_stars_using_subcommand projections" -l aspect-ratio -d 'ratio of font heigh to width' -r
complete -c stars -n "__fish_stars_using_subcommand projections" -s p -l projection -r -f -a "{azimuth-eq-rect\t'Azimuthal Equidistant Projection stretched to fit screen',azimuth-eq\t'Azimuthal Equidistant Projection',azimuth-eq-ellipse\t'Azimuthal Equidistant Projection stretched into an ellipse to fit screen',stereographic\t'Plot the altitude on the y axis and the azimuth on the x axis'}"
complete -c stars -n "__fish_stars_using_subcommand projections" -l circles -d 'create concentric circles at constant altitudes' -r
complete -c stars -n "__fish_stars_using_subcommand projections" -l random -d 'randomly dust with stars' -r
complete -c stars -n "__fish_stars_using_subcommand projections" -l coloring -r -f -a "{altitude\t'color all values at the same altitude the same',random\t'random coloring',none\t'no coloring'}"
complete -c stars -n "__fish_stars_using_subcommand projections" -s C -l config-file -d 'file to look for other command line args in' -r -F
complete -c stars -n "__fish_stars_using_subcommand projections" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c stars -n "__fish_stars_using_subcommand stars" -l star-shape -d 'symbol to use for star in terminal' -r
complete -c stars -n "__fish_stars_using_subcommand stars" -l aspect-ratio -d 'ratio of font heigh to width' -r
complete -c stars -n "__fish_stars_using_subcommand stars" -s p -l projection -r -f -a "{azimuth-eq-rect\t'Azimuthal Equidistant Projection stretched to fit screen',azimuth-eq\t'Azimuthal Equidistant Projection',azimuth-eq-ellipse\t'Azimuthal Equidistant Projection stretched into an ellipse to fit screen',stereographic\t'Plot the altitude on the y axis and the azimuth on the x axis'}"
complete -c stars -n "__fish_stars_using_subcommand stars" -s m -l max-magnitude -d 'maximum magnitude to display, note that higher magnitudes are less bright' -r
complete -c stars -n "__fish_stars_using_subcommand stars" -l coloring -r -f -a "{random\t'random coloring',constellations\t'color constellations',none\t'no coloring'}"
complete -c stars -n "__fish_stars_using_subcommand stars" -l shading -r -f -a "{none\t'no shading',saturation\t'shade by saturation (hsv)',value\t'shade by value (hsv)'}"
complete -c stars -n "__fish_stars_using_subcommand stars" -l shading-boost -r
complete -c stars -n "__fish_stars_using_subcommand stars" -l datetime-local -r
complete -c stars -n "__fish_stars_using_subcommand stars" -l datetime-utc -r
complete -c stars -n "__fish_stars_using_subcommand stars" -l lat -d 'Latitude to get stars for' -r
complete -c stars -n "__fish_stars_using_subcommand stars" -l lon -d 'longitude to get stars for' -r
complete -c stars -n "__fish_stars_using_subcommand stars" -l elevation -d 'elevation to get stars for' -r
complete -c stars -n "__fish_stars_using_subcommand stars" -s C -l config-file -d 'file to look for other command line args in' -r -F
complete -c stars -n "__fish_stars_using_subcommand stars" -l now
complete -c stars -n "__fish_stars_using_subcommand stars" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c stars -n "__fish_stars_using_subcommand completions" -s C -l config-file -d 'file to look for other command line args in' -r -F
complete -c stars -n "__fish_stars_using_subcommand completions" -s h -l help -d 'Print help'
complete -c stars -n "__fish_stars_using_subcommand help; and not __fish_seen_subcommand_from projections stars completions help" -f -a "projections"
complete -c stars -n "__fish_stars_using_subcommand help; and not __fish_seen_subcommand_from projections stars completions help" -f -a "stars"
complete -c stars -n "__fish_stars_using_subcommand help; and not __fish_seen_subcommand_from projections stars completions help" -f -a "completions"
complete -c stars -n "__fish_stars_using_subcommand help; and not __fish_seen_subcommand_from projections stars completions help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_stars_global_optspecs
	string join \n C/config-file= h/help V/version
end

function __fish_stars_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_stars_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_stars_using_subcommand
	set -l cmd (__fish_stars_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c stars -n "__fish_stars_needs_command" -s C -l config-file -d 'file to look for other command line args in' -r -F
complete -c stars -n "__fish_stars_needs_command" -s h -l help -d 'Print help'
complete -c stars -n "__fish_stars_needs_command" -s V -l version -d 'Print version'
complete -c stars -n "__fish_stars_needs_command" -f -a "projections"
complete -c stars -n "__fish_stars_needs_command" -f -a "stars"
complete -c stars -n "__fish_stars_needs_command" -f -a "completions"
complete -c stars -n "__fish_stars_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c stars -n "__fish_stars_using_subcommand projections" -l star-shape -d 'symbol to use for star in terminal' -r
complete -c stars -n "__fish_stars_using_subcommand projections" -l aspect-ratio -d 'ratio of font heigh to width' -r
complete -c stars -n "__fish_stars_using_subcommand projections" -s p -l projection -r -f -a "{azimuth-eq-rect\t'Azimuthal Equidistant Projection stretched to fit screen',azimuth-eq\t'Azimuthal Equidistant Projection',azimuth-eq-ellipse\t'Azimuthal Equidistant Projection stretched into an ellipse to fit screen',stereographic\t'Plot the altitude on the y axis and the azimuth on the x axis'}"
complete -c stars -n "__fish_stars_using_subcommand projections" -l circles -d 'create concentric circles at constant altitudes' -r
complete -c stars -n "__fish_stars_using_subcommand projections" -l random -d 'randomly dust with stars' -r
complete -c stars -n "__fish_stars_using_subcommand projections" -l coloring -r -f -a "{altitude\t'color all values at the same altitude the same',random\t'random coloring',none\t'no coloring'}"
complete -c stars -n "__fish_stars_using_subcommand projections" -s C -l config-file -d 'file to look for other command line args in' -r -F
complete -c stars -n "__fish_stars_using_subcommand projections" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c stars -n "__fish_stars_using_subcommand stars" -l star-shape -d 'symbol to use for star in terminal' -r
complete -c stars -n "__fish_stars_using_subcommand stars" -l aspect-ratio -d 'ratio of font heigh to width' -r
complete -c stars -n "__fish_stars_using_subcommand stars" -s p -l projection -r -f -a "{azimuth-eq-rect\t'Azimuthal Equidistant Projection stretched to fit screen',azimuth-eq\t'Azimuthal Equidistant Projection',azimuth-eq-ellipse\t'Azimuthal Equidistant Projection stretched into an ellipse to fit screen',stereographic\t'Plot the altitude on the y axis and the azimuth on the x axis'}"
complete -c stars -n "__fish_stars_using_subcommand stars" -s m -l max-magnitude -d 'maximum magnitude to display, note that higher magnitudes are less bright' -r
complete -c stars -n "__fish_stars_using_subcommand stars" -l coloring -r -f -a "{random\t'random coloring',constellations\t'color constellations',none\t'no coloring'}"
complete -c stars -n "__fish_stars_using_subcommand stars" -l shading -r -f -a "{none\t'no shading',saturation\t'shade by saturation (hsv)',value\t'shade by value (hsv)'}"
complete -c stars -n "__fish_stars_using_subcommand stars" -l shading-boost -r
complete -c stars -n "__fish_stars_using_subcommand stars" -l datetime-local -r
complete -c stars -n "__fish_stars_using_subcommand stars" -l datetime-utc -r
complete -c stars -n "__fish_stars_using_subcommand stars" -l lat -d 'Latitude to get stars for' -r
complete -c stars -n "__fish_stars_using_subcommand stars" -l lon -d 'longitude to get stars for' -r
complete -c stars -n "__fish_stars_using_subcommand stars" -l elevation -d 'elevation to get stars for' -r
complete -c stars -n "__fish_stars_using_subcommand stars" -s C -l config-file -d 'file to look for other command line args in' -r -F
complete -c stars -n "__fish_stars_using_subcommand stars" -l now
complete -c stars -n "__fish_stars_using_subcommand stars" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c stars -n "__fish_stars_using_subcommand completions" -s C -l config-file -d 'file to look for other command line args in' -r -F
complete -c stars -n "__fish_stars_using_subcommand completions" -s h -l help -d 'Print help'
complete -c stars -n "__fish_stars_using_subcommand help; and not __fish_seen_subcommand_from projections stars completions help" -f -a "projections"
complete -c stars -n "__fish_stars_using_subcommand help; and not __fish_seen_subcommand_from projections stars completions help" -f -a "stars"
complete -c stars -n "__fish_stars_using_subcommand help; and not __fish_seen_subcommand_from projections stars completions help" -f -a "completions"
complete -c stars -n "__fish_stars_using_subcommand help; and not __fish_seen_subcommand_from projections stars completions help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
