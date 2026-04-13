cmake_minimum_required(VERSION 3.16)

project(QuickDinner VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

# 1. Add QuickEffects and Core5Compat to find_package
find_package(Qt6 REQUIRED COMPONENTS Quick QuickEffects)

qt_standard_project_setup(REQUIRES 6.10)

qt_add_executable(appQuickDinner
    main.cpp
)

qt_add_qml_module(appQuickDinner
    URI QuickDinner
    VERSION 1.0
    QML_FILES
        Main.qml
        LandingPage.qml
        LoginSignPage.qml
        DashboardPage.qml
        BookingPage.qml
        HistoryPage.qml
        AdminPage.qml
    SOURCES
        reservationmanager.h reservationmanager.cpp
    RESOURCES                      # <--- Move this out!
        backgroundpict.jpeg
        secondbackground.jpeg
)

set_target_properties(appQuickDinner PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

# 2. Link the new modules to your target
target_link_libraries(appQuickDinner
    PRIVATE
        Qt6::Quick
        Qt6::QuickEffects
)

install(TARGETS appQuickDinner
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
