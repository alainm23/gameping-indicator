icon_sizes = ['48', '64', '128']

foreach i : icon_sizes
    install_data(
        join_paths('icons', i, meson.project_name() + '.svg'),
        install_dir: join_paths(get_option('datadir'), 'icons', 'hicolor', i + 'x' + i, 'apps')
    )
    install_data(
        join_paths('icons', i, meson.project_name() + '.svg'),
        install_dir: join_paths(get_option('datadir'), 'icons', 'hicolor', i + 'x' + i + '@2', 'apps')
    )

endforeach

install_data(
    'com.github.alainm23.gameping.desktop',
    install_dir: join_paths(get_option('datadir'), 'applications')
)

install_data(
    'com.github.alainm23.gameping.appdata.xml',
    install_dir: join_paths(get_option('datadir'), 'metainfo')
)

install_data(
	'com.github.alainm23.gameping-indicator',
    install_dir: get_option('bindir')
)
