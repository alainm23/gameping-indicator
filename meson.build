project('com.github.alainm23.gameping-indicator', 'vala', 'c',
    version: '0.0.1')

gnome = import('gnome')
i18n = import('i18n')

add_global_arguments('-DGETTEXT_PACKAGE="' + meson.project_name() + '"', language:'c')

asresources = gnome.compile_resources(
    'as-resources', 'data/' + meson.project_name() + '.gresource.xml',
    source_dir: 'data',
    c_name: 'as'
)

wingpanel_dep = dependency('wingpanel-2.0')

shared_module(
    meson.project_name(),
    
    'src/Indicator.vala',
    
    'src/Widgets/PopoverWidget.vala',
        
    'src/Services/Ping.vala',

    asresources,
    dependencies: [
    	dependency('gobject-2.0'),
        dependency('glib-2.0'),
        dependency('gtk+-3.0'),
        dependency('granite'),
        wingpanel_dep
    ],
    install: true,
    install_dir : get_option('libdir') + '/wingpanel'# wingpanel_dep.get_pkgconfig_variable('indicatorsdir')
)

subdir('data')

meson.add_install_script('meson/post_install.py')