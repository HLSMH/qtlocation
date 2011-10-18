/****************************************************************************
**
** Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the QtLocation module of the Qt Toolkit.
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

#ifndef QGEOROUTESEGMENT_H
#define QGEOROUTESEGMENT_H

#include <QExplicitlySharedDataPointer>
#include <QList>
#include <QtLocation/qlocationglobal.h>

QT_BEGIN_HEADER

QT_BEGIN_NAMESPACE



class QGeoCoordinate;
class QGeoManeuver;
class QGeoRouteSegmentPrivate;

class Q_LOCATION_EXPORT_TEMP QGeoRouteSegment
{

public:
    QGeoRouteSegment();
    QGeoRouteSegment(const QGeoRouteSegment &other);
    ~QGeoRouteSegment();

    QGeoRouteSegment& operator= (const QGeoRouteSegment &other);

    bool operator ==(const QGeoRouteSegment &other) const;
    bool operator !=(const QGeoRouteSegment &other) const;

    bool isValid() const;

    void setNextRouteSegment(const QGeoRouteSegment &routeSegment);
    QGeoRouteSegment nextRouteSegment() const;

    void setTravelTime(int secs);
    int travelTime() const;

    void setDistance(qreal distance);
    qreal distance() const;

    void setPath(const QList<QGeoCoordinate> &path);
    QList<QGeoCoordinate> path() const;

    void setManeuver(const QGeoManeuver &maneuver);
    QGeoManeuver maneuver() const;

protected:
    QGeoRouteSegment(QExplicitlySharedDataPointer<QGeoRouteSegmentPrivate> &d_ptr);

private:
    QExplicitlySharedDataPointer<QGeoRouteSegmentPrivate> d_ptr;
};

QT_END_NAMESPACE

QT_END_HEADER

#endif
