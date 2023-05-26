QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    chessdoc.cpp \
    chesssquare.cpp \
    chesssquaredialog.cpp \
    chessview.cpp \
    main.cpp \
    mainwindow.cpp

HEADERS += \
    chessdoc.h \
    chesssquare.h \
    chesssquaredialog.h \
    chessview.h \
    mainwindow.h

FORMS += \
    chesssquaredialog.ui \
    mainwindow.ui

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

RESOURCES += \
    resources.qrc
