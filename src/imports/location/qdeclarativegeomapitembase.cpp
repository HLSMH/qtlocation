/****************************************************************************
**
** Copyright (C) 2012 Nokia Corporation and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/
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
**
** $QT_END_LICENSE$
**
****************************************************************************/

#include "qdeclarativegeomapitembase_p.h"
#include "qdeclarativegeomapmousearea_p.h"
#include "qgeocameradata_p.h"
#include <QtQml/QQmlInfo>

QT_BEGIN_NAMESPACE

QGeoMapViewportChangeEvent::QGeoMapViewportChangeEvent()
    : zoomLevelChanged(false),
      centerChanged(false),
      mapSizeChanged(false),
      tiltChanged(false),
      bearingChanged(false),
      rollChanged(false)
{
}

QGeoMapViewportChangeEvent::QGeoMapViewportChangeEvent(const QGeoMapViewportChangeEvent &other)
    : cameraData(other.cameraData),
      mapSize(other.mapSize),
      zoomLevelChanged(other.zoomLevelChanged),
      centerChanged(other.centerChanged),
      mapSizeChanged(other.mapSizeChanged),
      tiltChanged(other.tiltChanged),
      bearingChanged(other.bearingChanged),
      rollChanged(other.rollChanged)
{
}

QDeclarativeGeoMapItemBase::QDeclarativeGeoMapItemBase(QQuickItem *parent)
    : QQuickItem(parent),
      map_(0),
      quickMap_(0)
{
    connect(this, SIGNAL(childrenChanged()),
            this, SLOT(afterChildrenChanged()));
}

QDeclarativeGeoMapItemBase::~QDeclarativeGeoMapItemBase()
{
    disconnect(this, SLOT(afterChildrenChanged()));
    if (quickMap_)
        quickMap_->removeMapItem(this);
}

/*!
    \internal
*/
void QDeclarativeGeoMapItemBase::afterChildrenChanged()
{
    QList<QQuickItem*> kids = childItems();
    if (kids.size() > 0) {
        bool printedWarning = false;
        foreach (QQuickItem *i, kids) {
            if (i->flags() & QQuickItem::ItemHasContents
                    && !qobject_cast<QDeclarativeGeoMapMouseArea*>(i)) {
                if (!printedWarning) {
                    qmlInfo(this) << "Geographic map items do not support child items";
                    printedWarning = true;
                }

                qmlInfo(i) << "deleting this child";
                i->deleteLater();
            }
        }
    }
}

/*!
    \internal
*/
bool QDeclarativeGeoMapItemBase::contains(QPointF point)
{
    Q_UNUSED(point);
    return true;
}

/*!
    \internal
*/
void QDeclarativeGeoMapItemBase::dragStarted()
{
}

/*!
    \internal
*/
void QDeclarativeGeoMapItemBase::dragEnded()
{
}

/*!
    \internal
*/
void QDeclarativeGeoMapItemBase::setMap(QDeclarativeGeoMap *quickMap, QGeoMap *map) {
    if (quickMap == quickMap_)
        return;
    if (quickMap && quickMap_)
        return; // don't allow association to more than one map
    if (quickMap_)
        quickMap_->disconnect(this);
    if (map_)
        map_->disconnect(this);

    quickMap_ = quickMap;
    map_ = map;

    if (map_ && quickMap_) {
        connect(map_, SIGNAL(cameraDataChanged(QGeoCameraData)),
                this, SLOT(baseCameraDataChanged(QGeoCameraData)));
        lastSize_ = QSizeF(quickMap_->width(), quickMap_->height());
        lastCameraData_ = map_->cameraData();
    }
}

/*!
    \internal
*/
void QDeclarativeGeoMapItemBase::baseCameraDataChanged(const QGeoCameraData &cameraData)
{
    QGeoMapViewportChangeEvent evt;
    evt.cameraData = cameraData;
    evt.mapSize = QSizeF(quickMap_->width(), quickMap_->height());

    if (evt.mapSize != lastSize_)
        evt.mapSizeChanged = true;

    if (cameraData.bearing() != lastCameraData_.bearing())
        evt.bearingChanged = true;
    if (cameraData.center() != lastCameraData_.center())
        evt.centerChanged = true;
    if (cameraData.roll() != lastCameraData_.roll())
        evt.rollChanged = true;
    if (cameraData.tilt() != lastCameraData_.tilt())
        evt.tiltChanged = true;
    if (cameraData.zoomLevel() != lastCameraData_.zoomLevel())
        evt.zoomLevelChanged = true;

    lastSize_ = evt.mapSize;
    lastCameraData_ = cameraData;

    afterViewportChanged(evt);
}

/*!
    \internal
*/
void QDeclarativeGeoMapItemBase::setPositionOnMap(const QGeoCoordinate& coordinate, const QPointF& offset)
{
    if (!map_ || !quickMap_)
        return;

    QPointF topLeft = map_->coordinateToScreenPosition(coordinate, false) - offset;

    if ((topLeft.x() > quickMap()->width())
            || (topLeft.x() + width() < 0)
            || (topLeft.y() + height() < 0)
            || (topLeft.y() > quickMap()->height())) {
        setVisible(false);
    } else {
        setVisible(true);
        setPos(topLeft);
    }
}

#include "moc_qdeclarativegeomapitembase_p.cpp"

QT_END_NAMESPACE
