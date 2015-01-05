///////////////////////////////////////////////////////////////////////////////
// $Id: ccolorcombobox.cpp 3810 2013-07-24 08:55:52Z tryhuk $
//
// 3DimViewer
// Lightweight 3D DICOM viewer.
//
// Copyright 2008-2012 3Dim Laboratory s.r.o.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
///////////////////////////////////////////////////////////////////////////////

#include <controls/ccolorcombobox.h>
#include <QPainter>

CColorComboBox::CColorComboBox(QComboBox *pCombo)
{
    m_pCombo=pCombo;
	m_bSyncActive = true;
}

CColorComboBox::~CColorComboBox()
{
}

void CColorComboBox::comboAddColorItem(const QColor& color, const QString& itemName)
{
    if (!m_pCombo) return;
    QPixmap pix(12, 12);
    QPainter painter(&pix);
    if (color.isValid()) {
        painter.setPen(Qt::gray);
        painter.setBrush(QBrush(color));
        painter.drawRect(0, 0, 12, 12);
    }
    QIcon icon;
    icon.addPixmap(pix);
    m_pCombo->addItem(icon,itemName,color);
}


////////////////////////////////////////////////////////////////////////////////////////////////////
//\fn void :::objectChanged(data::CRegionColoring *pData)
//
//\brief Redraw data.
//
//\param [in,out] pData If non-null, the data.
////////////////////////////////////////////////////////////////////////////////////////////////////

void CColorComboBox::objectChanged(data::CRegionColoring *pData)
{
    if (!m_pCombo) return;

    m_pCombo->blockSignals(true);

	int oldIndex = m_pCombo->currentIndex();

   // Clear old data
    m_pCombo->clear();

   // Fill combo with data

   data::CRegionColoring::tColor color;

   for( int i = 0; i < pData->getNumOfRegions(); ++i )
   {
      // Get color
      color = pData->getColor( i );

      QString regName = QString::fromUtf8(pData->getRegionInfo(i).getName().c_str());
      QColor  qcolor(color.getR(), color.getG(), color.getB());
      comboAddColorItem(qcolor,regName);
   }
   int index=pData->getActiveRegion();   
   if (m_bSyncActive)
	  m_pCombo->setCurrentIndex(index);
   else
	   if (oldIndex>=0 && oldIndex<m_pCombo->count())
		   m_pCombo->setCurrentIndex(oldIndex);
   m_pCombo->blockSignals(false);
}

void CColorComboBox::usualIndexChangedHandler(data::CDataStorage *pDataStorage, int index)
{
    Q_ASSERT(NULL!=pDataStorage);

    // Change the active region via data storage
    data::CObjectPtr<data::CRegionColoring> spColoring( pDataStorage->getEntry(data::Storage::RegionColoring::Id) );
    if( spColoring.get())
    {
        m_pCombo->blockSignals(true); // objectchanged of combo will be called, therefore we have to block signals
        spColoring->setActiveRegion( index );
        pDataStorage->invalidate(spColoring.getEntryPtr());
        m_pCombo->blockSignals(false); // objectchanged of combo will be called, therefore we have to block signals
    }
}
