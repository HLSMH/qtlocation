/****************************************************************************
**
** Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the test suite of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL$
** GNU Lesser General Public License Usage
** This file may be used under the terms of the GNU Lesser General Public
** License version 2.1 as published by the Free Software Foundation and
** appearing in the file LICENSE.LGPL included in the packaging of this
** file. Please review the following information to ensure the GNU Lesser
** General Public License version 2.1 requirements will be met:
** http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Nokia gives you certain additional
** rights. These rights are described in the Nokia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU General
** Public License version 3.0 as published by the Free Software Foundation
** and appearing in the file LICENSE.GPL included in the packaging of this
** file. Please review the following information to ensure the GNU General
** Public License version 3.0 requirements will be met:
** http://www.gnu.org/copyleft/gpl.html.
**
** Other Usage
** Alternatively, this file may be used in accordance with the terms and
** conditions contained in a signed written agreement between you and Nokia.
**
**
**
**
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.0
import QtTest 1.0
import QtLocation 5.0

Item {
    Plugin { id: nokiaPlugin; name: "nokia"}
    Plugin { id: invalidPlugin; name: "invalid"}
    Coordinate{ id: coordinate1; latitude: 51; longitude: 0}
    Coordinate{ id: coordinate2; latitude: 52; longitude: 0}
    BoundingBox{ id: boundingBox1; topLeft: coordinate2; bottomLeft: coordinate1; width:  1000}
    BoundingBox{ id: boundingBox2; topLeft: coordinate2; bottomLeft: coordinate1; width:  1000}

    Coordinate{ id: bottomLeft; latitude: 0; longitude: 0}
    Coordinate{ id: topLeft; latitude: 1; longitude: 0}
    Coordinate{ id: topRight; latitude: 1; longitude: 1}
    Coordinate{ id: bottomRight; latitude: 0; longitude: 1}
    Coordinate{ id: newTopRight; latitude: 3; longitude: 3}
    BoundingBox {
        id: unitBox;
        bottomLeft: bottomLeft;
        topLeft: topLeft;
        topRight: topRight;
        bottomRight: bottomRight}

    Route {id: emptyRoute}
    TestCase {
        name: "RouteManeuver RouteSegment and MapRoute"
        RouteSegment {id: emptySegment}
        RouteManeuver {id: emptyManeuver}

        // TODO enable when we have map route
        //MapRoute {id: emptyMapRoute}

        BoundingBox {id: emptyBox}
        Coordinate {id: emptyCoordinate}

        // TODO enable when we have map route
        /*
        SignalSpy {id: mapRouteDetailLevelSpy; target: emptyMapRoute; signalName: "detailLevelChanged"}
        SignalSpy {id: mapRouteColorSpy; target: emptyMapRoute.border; signalName: "colorChanged"}
        SignalSpy {id: mapRouteWidthSpy; target: emptyMapRoute.border; signalName: "widthChanged"}
        SignalSpy {id: mapRouteRouteSpy; target: emptyMapRoute; signalName: "routeChanged"}
        function test_maproute_defaults() {
            compare(mapRouteRouteSpy.count, 0)
            compare(mapRouteColorSpy.count, 0)
            compare(mapRouteDetailLevelSpy.count, 0)
            compare (emptyMapRoute.detailLevel, 6)
            emptyMapRoute.border.color = 'green'
            emptyMapRoute.detailLevel = 3
            compare(mapRouteRouteSpy.count, 0)
            compare(mapRouteColorSpy.count, 1)
            compare(mapRouteDetailLevelSpy.count, 1)
            emptyMapRoute.border.color = 'green'
            emptyMapRoute.detailLevel = 3
            compare(mapRouteColorSpy.count, 1)
            compare(mapRouteDetailLevelSpy.count, 1)
            emptyMapRoute.route = emptyRoute
            compare(mapRouteRouteSpy.count, 1)
            compare(emptyMapRoute.route, emptyRoute)
            // width
            compare(mapRouteWidthSpy.count, 0)
            emptyMapRoute.border.width = 123
            compare(mapRouteWidthSpy.count, 1)
            compare(emptyMapRoute.border.width, 123)
            emptyMapRoute.border.width = 123
            compare(mapRouteWidthSpy.count, 1)
            emptyMapRoute.border.width = -1
            compare(mapRouteWidthSpy.count, 1)
            compare(emptyMapRoute.border.width, 123)
            emptyMapRoute.border.width = 0
            compare(mapRouteWidthSpy.count, 1)
            compare(emptyMapRoute.border.width, 123)
        }
        */

        function test_route_defaults() {
            compare(emptyRoute.travelTime, 0)
            compare(emptyRoute.distance,0)
            compare(emptyRoute.path.length,0)
            compare(emptyRoute.segments.length,0)
            compare(emptyRoute.bounds.topLeft.latitude, emptyBox.topLeft.latitude)
            compare(emptyRoute.bounds.bottomRight.longitude, emptyBox.bottomRight.longitude)
        }

        function test_routesegment_defaults() {
            compare(emptySegment.travelTime, 0)
            compare(emptySegment.distance, 0)
            compare(emptySegment.path.length, 0)
            compare(emptySegment.maneuver.valid, emptyManeuver.valid)
            compare(emptySegment.maneuver.instructionText, emptyManeuver.instructionText)
            compare(emptySegment.maneuver.waypointValid, emptyManeuver.waypointValid)
        }
        function test_maneuver_defaults() {
            compare(emptyManeuver.valid, false)
            compare(emptyManeuver.instructionText, "")
            compare(emptyManeuver.direction, RouteManeuver.NoDirection)
            compare(emptyManeuver.timeToNextInstruction,0)
            compare(emptyManeuver.distanceToNextInstruction,0)
            compare(emptyManeuver.waypoint.latitude, emptyCoordinate.latitude)
            compare(emptyManeuver.waypoint.longitude, emptyCoordinate.longitude)
            compare(emptyManeuver.position.latitude, emptyCoordinate.latitude)
            compare(emptyManeuver.position.longitude, emptyCoordinate.longitude)
        }
    }

    TestCase {
        name: "MapRouteModel and MapRouteQuery"
        RouteModel {id: emptyModel}
        RouteQuery {id: emptyQuery}

        function test_model_default_properties() {
            compare (emptyModel.autoUpdate, false, "Automatic update")
            compare (emptyModel.status, RouteModel.Null, "Model status")
            compare (emptyModel.errorString, "", "Model error")
            compare (emptyModel.error, RouteModel.NoError)
            compare (emptyModel.count, 0, "Model count")
            emptyModel.get(192) // don't do stupid

            compare (emptyQuery.numberAlternativeRoutes, 0, "Number of alternative routes")
            compare (emptyQuery.travelModes, RouteQuery.CarTravel, "Travel mode")
            compare (emptyQuery.routeOptimizations, RouteQuery.FastestRoute, "Route optimization")
            compare (emptyQuery.segmentDetail, RouteQuery.BasicSegmentData)
            compare (emptyQuery.maneuverDetail, RouteQuery.BasicManeuvers)
            compare (emptyQuery.waypoints.length, 0, "Waypoints")
            compare (emptyQuery.excludedAreas.length, 0, "excluded areas")
            // Bug in QtDeclarative. Todo, enable when QList<int> support is done
            //compare (emptyQuery.featureTypes.length, 0, "Feature types")
        }

        SignalSpy {id: autoUpdateSpy; target: emptyModel; signalName: "autoUpdateChanged"}
        SignalSpy {id: pluginSpy; target: emptyModel ; signalName: "pluginChanged"}

        SignalSpy {id: travelModesSpy; target: emptyQuery; signalName: "travelModesChanged"}
        SignalSpy {id: waypointsSpy; target: emptyQuery; signalName: "waypointsChanged"}
        SignalSpy {id: exclusionSpy; target: emptyQuery; signalName: "excludedAreasChanged"}
        SignalSpy {id: featureTypesSpy; target: emptyQuery; signalName: "featureTypesChanged"}
        SignalSpy {id: segmentDetailSpy; target: emptyQuery; signalName: "segmentDetailChanged"}
        SignalSpy {id: maneuverDetailSpy; target: emptyQuery; signalName: "maneuverDetailChanged"}
        SignalSpy {id: numberAlterNativeRoutesSpy; target: emptyQuery; signalName: "numberAlternativeRoutesChanged"}
        SignalSpy {id: routeOptimizationsSpy; target: emptyQuery; signalName: "routeOptimizationsChanged"}
        SignalSpy {id: queryDetailsChangedSpy; target: emptyQuery; signalName: "queryDetailsChanged"}
        function test_model_setters() {
            // Autoupdate
            compare(autoUpdateSpy.count, 0)
            emptyModel.autoUpdate = true
            compare(autoUpdateSpy.count, 1)
            compare(emptyModel.autoUpdate, true)
            emptyModel.autoUpdate = true // mustn't retrigger 'changed' -signal
            compare(autoUpdateSpy.count, 1)
            emptyModel.autoUpdate = false
            compare(autoUpdateSpy.count, 2)

            // Travelmodes
            compare(travelModesSpy.count, 0)
            emptyQuery.travelModes = RouteQuery.BicycleTravel
            compare(travelModesSpy.count, 1)
            compare(emptyQuery.travelModes, RouteQuery.BicycleTravel)
            emptyQuery.travelModes = RouteQuery.BicycleTravel | RouteQuery.PedestrianTravel
            compare(emptyQuery.travelModes, RouteQuery.BicycleTravel | RouteQuery.PedestrianTravel)
            compare(travelModesSpy.count, 2)
            compare(queryDetailsChangedSpy.count, 2)

            // Basic adding and removing of waypoint
            queryDetailsChangedSpy.clear()
            compare(waypointsSpy.count, 0)
            emptyQuery.addWaypoint(coordinate1)
            compare(waypointsSpy.count, 1)
            compare(queryDetailsChangedSpy.count, 1)
            emptyQuery.addWaypoint(coordinate1)
            compare(waypointsSpy.count, 2)
            compare(queryDetailsChangedSpy.count, 2)
            compare(emptyQuery.waypoints.length, 2)
            emptyQuery.removeWaypoint(coordinate1)
            compare(waypointsSpy.count, 3)
            compare(queryDetailsChangedSpy.count, 3)
            compare(emptyQuery.waypoints.length, 1)
            emptyQuery.removeWaypoint(coordinate2) // coordinate2 isn't in the list, must not impact
            compare(waypointsSpy.count, 3)
            compare(queryDetailsChangedSpy.count, 3)
            emptyQuery.removeWaypoint(coordinate1)
            compare(waypointsSpy.count, 4)
            emptyQuery.removeWaypoint(coordinate1) // doesn't exist anymore, must not impact
            compare(waypointsSpy.count, 4)
            compare(emptyQuery.waypoints.length, 0)
            // Check correct ordering of waypoints
            waypointsSpy.clear()
            emptyQuery.addWaypoint(coordinate1)
            emptyQuery.addWaypoint(coordinate2)
            emptyQuery.addWaypoint(coordinate1)
            emptyQuery.addWaypoint(coordinate2)
            compare(waypointsSpy.count, 4)
            compare(emptyQuery.waypoints[0], coordinate1)
            compare(emptyQuery.waypoints[1], coordinate2)
            compare(emptyQuery.waypoints[2], coordinate1)
            compare(emptyQuery.waypoints[3], coordinate2)
            emptyQuery.removeWaypoint(coordinate1) // remove one from the middle, check that one added last is removed
            compare(emptyQuery.waypoints[0], coordinate1)
            compare(emptyQuery.waypoints[1], coordinate2)
            compare(emptyQuery.waypoints[2], coordinate2)
            waypointsSpy.clear()
            emptyQuery.clearWaypoints()
            compare(emptyQuery.waypoints.length, 0)
            compare(waypointsSpy.count, 1)

            // Altering the waypoint contents should trigger signal
            emptyQuery.clearWaypoints()
            emptyQuery.addWaypoint(coordinate1)
            queryDetailsChangedSpy.clear()
            coordinate1.latitude = 41
            compare (queryDetailsChangedSpy.count, 1)
            coordinate1.longitude = 1
            compare (queryDetailsChangedSpy.count, 2)
            coordinate1.altitude = 1
            compare (queryDetailsChangedSpy.count, 3)
            // verify coordinate is disconnected
            emptyQuery.removeWaypoint(coordinate1)
            compare (queryDetailsChangedSpy.count, 4)
            coordinate1.latitude = 46
            compare (queryDetailsChangedSpy.count, 4)
            // verify that same coordinate instance only produces one set of changes
            emptyQuery.addWaypoint(coordinate1)
            emptyQuery.addWaypoint(coordinate1)
            compare (emptyQuery.waypoints.length, 2)
            queryDetailsChangedSpy.clear()
            coordinate1.latitude = 61
            compare (queryDetailsChangedSpy.count, 1)
            // verify that removing duplicat coordinate leaves remaining ones correctly connected
            emptyQuery.removeWaypoint(coordinate1)
            compare (queryDetailsChangedSpy.count, 2)
            compare (emptyQuery.waypoints.length, 1)
            coordinate1.latitude = 69
            compare (queryDetailsChangedSpy.count, 3)
            // verify that clearing works
            emptyQuery.clearWaypoints()
            compare (queryDetailsChangedSpy.count, 4)
            compare (emptyQuery.waypoints.length, 0)
            coordinate1.latitude = 62
            compare (queryDetailsChangedSpy.count, 4)

            // Excluded areas
            queryDetailsChangedSpy.clear()
            compare(exclusionSpy.count, 0)
            emptyQuery.addExcludedArea(boundingBox1)
            compare(exclusionSpy.count, 1)
            compare(queryDetailsChangedSpy.count, 1)
            emptyQuery.addExcludedArea(boundingBox1)
            // doesn't make sense to put same area twice
            compare(exclusionSpy.count, 1)
            compare(queryDetailsChangedSpy.count, 1)
            compare(emptyQuery.excludedAreas.length, 1)
            emptyQuery.removeExcludedArea(boundingBox1)
            compare(exclusionSpy.count, 2)
            compare(queryDetailsChangedSpy.count, 2)
            compare(emptyQuery.excludedAreas.length, 0)
            emptyQuery.removeExcludedArea(boundingBox2) // boundingBox2 isn't in the list, must not impact
            compare(exclusionSpy.count, 2)
            compare(queryDetailsChangedSpy.count, 2)
            emptyQuery.removeExcludedArea(boundingBox1) // doesn't exist anymore, must not impact
            compare(exclusionSpy.count, 2)
            compare(queryDetailsChangedSpy.count, 2)
            // Check correct ordering of exclusion
            exclusionSpy.clear()
            emptyQuery.addExcludedArea(boundingBox1)
            emptyQuery.addExcludedArea(boundingBox2)
            emptyQuery.addExcludedArea(boundingBox1)
            emptyQuery.addExcludedArea(boundingBox2)
            compare(exclusionSpy.count, 2)
            compare(emptyQuery.excludedAreas[0], boundingBox1)
            compare(emptyQuery.excludedAreas[1], boundingBox2)
            emptyQuery.removeExcludedArea(boundingBox1) // remove first and check all geos ok
            compare(emptyQuery.excludedAreas[0], boundingBox2)
            exclusionSpy.clear()
            emptyQuery.clearExcludedAreas()
            compare(emptyQuery.excludedAreas.length, 0)
            compare(exclusionSpy.count, 1)

            // Altering exclusion area details should trigger signals
            emptyQuery.clearExcludedAreas()
            emptyQuery.addExcludedArea(unitBox)
            queryDetailsChangedSpy.clear()
            compare (emptyQuery.excludedAreas.length, 1)
            unitBox.width = 200
            compare(queryDetailsChangedSpy.count, 1)
            unitBox.height = 200
            compare(queryDetailsChangedSpy.count, 2)
            unitBox.topRight = newTopRight
            compare(queryDetailsChangedSpy.count, 5)
            // verify box is disconnected
            emptyQuery.removeExcludedArea(unitBox)
            compare (queryDetailsChangedSpy.count, 6)
            unitBox.height = 400
            compare (queryDetailsChangedSpy.count, 6)
            // verify that same box instance only produces one set of changes
            compare (emptyQuery.excludedAreas.length, 0)
            emptyQuery.addExcludedArea(unitBox)
            emptyQuery.addExcludedArea(unitBox)
            compare (emptyQuery.excludedAreas.length, 1)
            queryDetailsChangedSpy.clear()
            unitBox.width = 777
            compare (queryDetailsChangedSpy.count, 1)
            compare (emptyQuery.excludedAreas.length, 1)
            unitBox.width = 200
            compare (queryDetailsChangedSpy.count, 2)
            // verify that clearing works
            emptyQuery.clearExcludedAreas()
            compare (queryDetailsChangedSpy.count, 3)
            compare (emptyQuery.excludedAreas.length, 0)
            unitBox.width = 717
            compare (queryDetailsChangedSpy.count, 3)

            // Feature types and weights
            queryDetailsChangedSpy.clear()
            // Bug in QtDeclarative. Todo, enable when QList<int> support is done
            //compare(emptyQuery.featureTypes.length, 0)
            compare(featureTypesSpy.count, 0)
            emptyQuery.setFeatureWeight(RouteQuery.TollFeature, RouteQuery.AvoidFeatureWeight);
            compare(featureTypesSpy.count, 1)
            compare(queryDetailsChangedSpy.count, 1)
            emptyQuery.setFeatureWeight(RouteQuery.HighwayFeature, RouteQuery.PreferFeatureWeight);
            compare(featureTypesSpy.count, 2)
            compare(queryDetailsChangedSpy.count, 2)
            // Bug in QtDeclarative. Todo, enable when QList<int> support is done
            //compare(emptyQuery.featureTypes.length, 2)
            //compare(emptyQuery.featureTypes[0], RouteQuery.TollFeature)
            //compare(emptyQuery.featureTypes[1], RouteQuery.HighwayFeature)
            // Verify feature weights are as set
            compare(emptyQuery.featureWeight(RouteQuery.TollFeature), RouteQuery.AvoidFeatureWeight);
            compare(emptyQuery.featureWeight(RouteQuery.HighwayFeature), RouteQuery.PreferFeatureWeight);
            // Neutralize a weight, feature should disappear
            emptyQuery.setFeatureWeight(RouteQuery.TollFeature, RouteQuery.NeutralFeatureWeight);
            compare(featureTypesSpy.count, 3)
            compare(queryDetailsChangedSpy.count, 3)
            // Bug in QtDeclarative. Todo, enable when QList<int> support is done
            //compare(emptyQuery.featureTypes.length, 1)
            compare(emptyQuery.featureWeight(RouteQuery.TollFeature), RouteQuery.NeutralFeatureWeight);
            compare(emptyQuery.featureWeight(RouteQuery.HighwayFeature), RouteQuery.PreferFeatureWeight);
            // Bug in QtDeclarative. Todo, enable when QList<int> support is done
            //compare(emptyQuery.featureTypes[0], RouteQuery.HighwayFeature)
            //compare(emptyQuery.featureWeight(emptyQuery.featureTypes[0]), RouteQuery.PreferFeatureWeight)
            compare(featureTypesSpy.count, 3)
            compare(queryDetailsChangedSpy.count, 3)
            // Bug in QtDeclarative. Todo, enable when QList<int> support is done
            //compare(emptyQuery.featureTypes.length, 1)

            // Put some feature weights and then reset them with NoFeature
            emptyQuery.setFeatureWeight(RouteQuery.FerryFeature, RouteQuery.RequireFeatureWeight);
            emptyQuery.setFeatureWeight(RouteQuery.MotorPoolLaneFeature, RouteQuery.DisallowFeatureWeight);
            compare(featureTypesSpy.count, 5)
            compare(queryDetailsChangedSpy.count, 5)
            // Bug in QtDeclarative. Todo, enable when QList<int> support is done
            //compare(emptyQuery.featureTypes.length, 3)
            emptyQuery.setFeatureWeight(RouteQuery.NoFeature, RouteQuery.NeutralFeatureWeight)
            compare(featureTypesSpy.count, 6)
            compare(queryDetailsChangedSpy.count, 6)
            // Bug in QtDeclarative. Todo, enable when QList<int> support is done
            //compare(emptyQuery.featureTypes.length, 0)

            // Segment details
            queryDetailsChangedSpy.clear()
            compare(segmentDetailSpy.count, 0)
            compare(emptyQuery.segmentDetail, RouteQuery.BasicSegmentData)
            emptyQuery.segmentDetail = RouteQuery.NoSegmentData
            compare(segmentDetailSpy.count, 1)
            compare(queryDetailsChangedSpy.count, 1)
            compare(emptyQuery.segmentDetail, RouteQuery.NoSegmentData)
            emptyQuery.segmentDetail = RouteQuery.NoSegmentData
            compare(segmentDetailSpy.count, 1)
            compare(queryDetailsChangedSpy.count, 1)
            compare(emptyQuery.segmentDetail, RouteQuery.NoSegmentData)

            // Maneuver details
            queryDetailsChangedSpy.clear()
            compare(maneuverDetailSpy.count, 0)
            compare(emptyQuery.maneuverDetail, RouteQuery.BasicManeuvers)
            emptyQuery.maneuverDetail = RouteQuery.NoManeuvers
            compare(maneuverDetailSpy.count, 1)
            compare(queryDetailsChangedSpy.count, 1)
            compare(emptyQuery.maneuverDetail, RouteQuery.NoManeuvers)
            emptyQuery.maneuverDetail = RouteQuery.NoManeuvers
            compare(maneuverDetailSpy.count, 1)
            compare(queryDetailsChangedSpy.count, 1)
            compare(emptyQuery.maneuverDetail, RouteQuery.NoManeuvers)

            // NumberAlternativeRoutes
            queryDetailsChangedSpy.clear()
            compare(numberAlterNativeRoutesSpy.count, 0)
            compare(emptyQuery.numberAlternativeRoutes, 0)
            emptyQuery.numberAlternativeRoutes = 2
            compare(numberAlterNativeRoutesSpy.count, 1)
            compare(queryDetailsChangedSpy.count, 1)
            compare(emptyQuery.numberAlternativeRoutes, 2)
            emptyQuery.numberAlternativeRoutes = 2
            compare(numberAlterNativeRoutesSpy.count, 1)
            compare(queryDetailsChangedSpy.count, 1)
            compare(emptyQuery.numberAlternativeRoutes, 2)

            // Route optimization
            queryDetailsChangedSpy.clear()
            compare(routeOptimizationsSpy.count, 0)
            compare(emptyQuery.routeOptimizations, RouteQuery.FastestRoute)
            emptyQuery.routeOptimizations = RouteQuery.ShortestRoute
            compare(routeOptimizationsSpy.count, 1)
            compare(queryDetailsChangedSpy.count, 1)
            compare(emptyQuery.routeOptimizations, RouteQuery.ShortestRoute)
            emptyQuery.routeOptimizations = RouteQuery.ShortestRoute | RouteQuery.MostScenicRoute
            compare(routeOptimizationsSpy.count, 2)
            compare(queryDetailsChangedSpy.count, 2)
            compare(emptyQuery.routeOptimizations, RouteQuery.ShortestRoute | RouteQuery.MostScenicRoute)

            // Must act gracefully
            emptyModel.clear()
            emptyModel.update()

            // Plugin
            compare(pluginSpy.count, 0)
            emptyModel.plugin = nokiaPlugin
            compare(pluginSpy.count, 1)
            compare(emptyModel.plugin, nokiaPlugin)
            emptyModel.plugin = nokiaPlugin
            compare(pluginSpy.count, 1)
            emptyModel.plugin = invalidPlugin
            compare(pluginSpy.count, 2)

            // Must act gracefully
            emptyModel.clear()
            emptyModel.update()
        }
        // Test that model acts gracefully when plugin is not set or is invalid
        // (does not support routing)
        RouteModel {id: invalidModel; plugin: invalidPlugin}
        SignalSpy {id: countInvalidSpy; target: invalidModel; signalName: "countChanged"}
        function test_invalid_plugin() {
            invalidModel.update()
            invalidModel.clear()
            invalidModel.reset()
            invalidModel.update()
            invalidModel.get(-1)
            invalidModel.get(1)
        }
    }

    Plugin {
        id: testPlugin_immediate;
        name: "qmlgeo.test.plugin"
        parameters: [
            // Parms to guide the test plugin
            PluginParameter { name: "gc_supported"; value: true},
            PluginParameter { name: "gc_finishRequestImmediately"; value: true},
            PluginParameter { name: "gc_validateWellKnownValues"; value: true}
        ]
    }

    Plugin {
        id: testPlugin_slacker;
        name: "qmlgeo.test.plugin"
        parameters: [
            // Parms to guide the test plugin
            PluginParameter { name: "gc_finishRequestImmediately"; value: false}
        ]
    }

    Plugin {
        id: bacicRoutingPlugin_slacker;
        name: "qmlgeo.test.plugin"
        parameters: [
            // Parms to guide the test plugin
            PluginParameter { name: "gc_finishRequestImmediately"; value: false}
        ]
    }

    Coordinate {id: rcoordinate1; latitude: 50; longitude: 50}
    Coordinate {id: rcoordinate2; latitude: 51; longitude: 52}
    Coordinate {id: rcoordinate3; latitude: 53; longitude: 54}
    Coordinate {id: rcoordinate4; latitude: 55; longitude: 56}
    Coordinate {id: rcoordinate5; latitude: 57; longitude: 58}

    RouteQuery {id: routeQuery}
    RouteQuery {id: filledRouteQuery;
        numberAlternativeRoutes: 1
        waypoints: [
            Coordinate {id: fcoordinate1; latitude: 60; longitude: 60},
            Coordinate {id: fcoordinate2; latitude: 61; longitude: 62},
            Coordinate {id: fcoordinate3; latitude: 63; longitude: 64},
            Coordinate {id: fcoordinate4; latitude: 65; longitude: 66},
            Coordinate {id: fcoordinate5; latitude: 67; longitude: 68}
        ]
    }
    RouteQuery {id: filledRouteQuery2;
        waypoints: [
            Coordinate {id: f2coordinate1; latitude: 60; longitude: 60},
            Coordinate {id: f2coordinate2; latitude: 61; longitude: 62},
            Coordinate {id: f2coordinate3; latitude: 63; longitude: 64}
        ]
    }
    RouteModel {
        id: routeModelAutomatic;
        plugin: testPlugin_slacker;
        query: filledRouteQuery;
        autoUpdate: true
    }

    SignalSpy {id: automaticRoutesSpy; target: routeModelAutomatic; signalName: "routesChanged" }

    RouteModel {id: routeModel; plugin: testPlugin_immediate; query: routeQuery }
    SignalSpy {id: testRoutesSpy; target: routeModel; signalName: "routesChanged"}
    SignalSpy {id: testCountSpy; target: routeModel; signalName: "countChanged" }
    SignalSpy {id: testStatusSpy; target: routeModel; signalName: "statusChanged"}
    SignalSpy {id: testErrorStringSpy; target: routeModel; signalName: "errorStringChanged"}
    SignalSpy {id: testErrorSpy; target: routeModel; signalName: "errorChanged"}
    SignalSpy {id: testWaypointsSpy; target: routeQuery; signalName: "waypointsChanged"}

    RouteModel {id: routeModelSlack; plugin: bacicRoutingPlugin_slacker; query: routeQuery }
    SignalSpy {id: testRoutesSlackSpy; target: routeModelSlack; signalName: "routesChanged"}
    SignalSpy {id: testCountSlackSpy; target: routeModelSlack; signalName: "countChanged" }
    SignalSpy {id: testStatusSlackSpy; target: routeModelSlack; signalName: "statusChanged"}
    SignalSpy {id: testErrorStringSlackSpy; target: routeModelSlack; signalName: "errorStringChanged"}
    SignalSpy {id: testErrorSlackSpy; target: routeModelSlack; signalName: "errorChanged"}
    SignalSpy {id: testPluginSlackSpy; target: routeModelSlack; signalName: "pluginChanged"}

    TestCase {
        name: "Routing"
        function clear_immediate_model() {
            routeModel.clear()
            testRoutesSpy.clear()
            testCountSpy.clear()
            testStatusSpy.clear()
            testErrorStringSpy.clear()
            testErrorSpy.clear()
        }
        function clear_slacker_model() {
            routeModelSlack.clear()
            testRoutesSlackSpy.clear()
            testCountSlackSpy.clear()
            testStatusSlackSpy.clear()
            testErrorStringSlackSpy.clear()
            testErrorSlackSpy.clear()
        }

        function test_reset() {
            clear_immediate_model();
            routeQuery.numberAlternativeRoutes = 72 // 'altroutes - 70' is the echoed errorcode
            routeModel.update()
            verify (testErrorStringSpy.count > 0)
            verify (testErrorSpy.count > 0)
            compare (routeModel.errorString, "error")
            compare (routeModel.error, RouteModel.CommunicationError)
            compare (routeModel.count, 0)
            compare (testStatusSpy.count, 2)
            compare (routeModel.status, RouteModel.Error)
            routeModel.reset()
            compare (routeModel.status, RouteModel.Null)
            compare (routeModel.errorString, "")
            compare (routeModel.error, RouteModel.NoError)
            // Check that ongoing req is aborted
            clear_slacker_model()
            routeQuery.numberAlternativeRoutes = 3
            routeModelSlack.update()
            wait (100)
            routeModelSlack.reset()
            wait (200)
            compare (routeModelSlack.count, 0)
            // Check that results are cleared
            routeModelSlack.update()
            wait (300)
            compare (routeModelSlack.count, 3) // numberALternativeRoutes
            routeModelSlack.reset()
            compare (routeModelSlack.count, 0)
            // Check that changing plugin resets any ongoing requests
            clear_slacker_model()
            routeQuery.numberAlternativeRoutes = 3
            compare (testPluginSlackSpy.count, 0)
            routeModelSlack.update()
            wait (100)
            routeModelSlack.plugin = testPlugin_immediate
            wait (200)
            compare (routeModelSlack.count, 0) // should be no updates
            compare (testPluginSlackSpy.count, 1)
            // test that works
            routeModelSlack.update()
            compare (routeModelSlack.count, 3)
            // return back
            routeModelSlack.plugin = testPlugin_slacker
        }

        function test_error_routing() {
            // Basic immediate error
            clear_immediate_model();
            routeQuery.numberAlternativeRoutes = 72 // 'altroutes - 70' is the echoed errorcode
            routeModel.update()
            compare (testErrorStringSpy.count, 1)
            compare (testErrorSpy.count, 1)
            compare (routeModel.errorString, "error")
            compare (routeModel.error, RouteModel.CommunicationError)
            compare (routeModel.count, 0)
            compare (testStatusSpy.count, 2)
            compare (routeModel.status, RouteModel.Error)
            // Basic delayed error
            clear_slacker_model()
            routeQuery.numberAlternativeRoutes = 72
            routeModelSlack.update()
            compare (testErrorStringSlackSpy.count, 0)
            compare (testErrorSlackSpy.count, 0)
            if (routeModelSlack.errorString == "")
                tryCompare(testErrorStringSlackSpy, "count", 1)
            else
                tryCompare(testErrorStringSlackSpy, "count", 2)
            compare (routeModelSlack.errorString, "error")
            compare (routeModelSlack.error, RouteModel.CommunicationError)
            compare (routeModelSlack.count, 0)
            // check that we recover
            routeQuery.numberAlternativeRoutes = 1
            routeModelSlack.update()
            tryCompare(routeModelSlack, "count", 1)
            compare (testCountSlackSpy.count, 1)
            compare (routeModelSlack.errorString, "")
            compare (routeModelSlack.error, RouteModel.NoError)
        }
        function test_basic_routing() {
            compare (testRoutesSpy.count, 0)
            compare (routeModel.errorString, "")
            compare (routeModel.error, RouteModel.NoError)
            compare (testCountSpy.count, 0)
            compare (routeModel.count, 0)
            compare (routeQuery.waypoints.length, 0)
            compare (testWaypointsSpy.count, 0)
            routeQuery.addWaypoint(rcoordinate1)
            routeQuery.addWaypoint(rcoordinate2)
            routeQuery.addWaypoint(rcoordinate3)
            routeQuery.addWaypoint(rcoordinate4)
            routeQuery.addWaypoint(rcoordinate5)
            compare (testWaypointsSpy.count, 5)
            compare (routeQuery.waypoints.length, 5)
            routeQuery.numberAlternativeRoutes = 1 // how many routes to get back, > 70 indicates error
            routeModel.update()
            tryCompare (testRoutesSpy, "count", 1) // 5 sec
            tryCompare (testCountSpy, "count", 1)
            compare (routeModel.count, 1)
             // the test plugin echoes waypoints back as the path of the route:
            compare (routeQuery.waypoints.length, 5)
            compare (routeModel.get(0).path.length, 5)
            compare (routeModel.get(0).path[0].latitude, routeQuery.waypoints[0].latitude)
            // check clear() functionality
            routeModel.clear()
            tryCompare (testRoutesSpy, "count", 2) // 5 sec
            tryCompare (testCountSpy, "count", 2)
            compare (routeModel.count, 0)

            // delayed responses
            compare (testRoutesSlackSpy.count, 0)
            compare (routeModelSlack.errorString, "")
            compare (routeModel.error, RouteModel.NoError)
            compare (testCountSlackSpy.count, 0)
            compare (routeModelSlack.count, 0)
            routeModelSlack.update()
            wait (100)
            compare (testRoutesSlackSpy.count, 0)
            compare (testCountSlackSpy.count, 0)
            wait (200)
            compare (testRoutesSlackSpy.count, 1)
            compare (testCountSlackSpy.count, 1)
            compare(routeModelSlack.count, 1)
            compare (routeModelSlack.get(0).path.length, 5)
            compare (routeModelSlack.get(0).path[0].latitude, routeQuery.waypoints[0].latitude)

            // Frequent updates, previous requests are aborted
            routeModelSlack.clear()
            testRoutesSlackSpy.clear()
            testCountSlackSpy.clear()
            routeModelSlack.update()
            wait (100)
            compare(testRoutesSlackSpy.count, 0)
            compare(testCountSlackSpy.count, 0)
            routeModelSlack.update()
            wait (100)
            compare(testRoutesSlackSpy.count, 0)
            compare(testCountSlackSpy.count, 0)
            routeModelSlack.update()
            wait (100)
            compare(testRoutesSlackSpy.count, 0)
            compare(testCountSlackSpy.count, 0)
            routeModelSlack.update()
            wait (100)
            compare(testRoutesSlackSpy.count, 0)
            compare(testCountSlackSpy.count, 0)
            wait (200)
            compare (testRoutesSlackSpy.count, 1)
            compare(testCountSlackSpy.count, 1)
            compare(routeModelSlack.count, 1)

            // Autoupdate
            filledRouteQuery.numberAlternativeRoutes = 1 // 'altroutes - 70' is the echoed errorcode
            wait (300)
            automaticRoutesSpy.clear()
            compare(routeModelAutomatic.count, 1) // There should be a route already
            compare (routeModelAutomatic.get(0).path.length, 5)
            compare (routeModelAutomatic.get(0).path[0].latitude, filledRouteQuery.waypoints[0].latitude)

            // Remove a waypoint and check that autoupdate works
            filledRouteQuery.removeWaypoint(fcoordinate2)
            wait(300)
            compare (routeModelAutomatic.get(0).path.length, 4)
            compare (routeModelAutomatic.get(0).path[0].latitude, fcoordinate1.latitude)
            compare (automaticRoutesSpy.count, 1)

            // Change contents of a coordinate and check that autoupdate works
            fcoordinate1.latitude++
            wait(300)
            compare (routeModelAutomatic.get(0).path[0].latitude, fcoordinate1.latitude) // new value should be echoed
            compare (automaticRoutesSpy.count, 2)
            // Change query
            routeModelAutomatic.query = filledRouteQuery2
            filledRouteQuery2.numberAlternativeRoutes = 3
            wait(300)
            compare (routeModelAutomatic.get(0).path.length, 3)
            compare (automaticRoutesSpy.count, 3)
            // Verify that the old query is disconnected internally ie. does not trigger update
            fcoordinate1.latitude++
            wait(300)
            compare (automaticRoutesSpy.count, 3)
        }
    }
}




