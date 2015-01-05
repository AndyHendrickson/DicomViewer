///////////////////////////////////////////////////////////////////////////////
// $Id: ccolorcombobox.h 3810 2013-07-24 08:55:52Z tryhuk $
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

#ifndef CColorComboBox_H
#define CColorComboBox_H

#include <data/CRegionColoring.h>

#include <QComboBox>
#include <QColor>
#include <QString>

//! Extension of combobox for region coloring
class CColorComboBox : public data::CObjectObserver< data::CRegionColoring >
{
protected:
    QComboBox*  m_pCombo;
	bool		m_bSyncActive;
    void        comboAddColorItem(const QColor& color, const QString& itemName);
public:
    CColorComboBox(QComboBox* pCombo=NULL);
    ~CColorComboBox();
    void        setCombo(QComboBox* pCombo) { m_pCombo=pCombo; }
    QComboBox*  getCombo() const { return m_pCombo; }

    //! implementation of usual index change handler
    void        usualIndexChangedHandler(data::CDataStorage *pDataStorage, int index);

	//! sync active region index on change
	void		setSyncActiveRegion(bool bSyncActive) { m_bSyncActive = bSyncActive; } 

    //! Redraw data
    void objectChanged(data::CRegionColoring *pData);
};


#endif
