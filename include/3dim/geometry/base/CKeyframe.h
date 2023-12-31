///////////////////////////////////////////////////////////////////////////////
//
// 3DimViewer
// Lightweight 3D DICOM viewer.
//
// Copyright 2008-2015 3Dim Laboratory s.r.o.
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

#ifndef CKEYFRAME_H
#define CKEYFRAME_H

////////////////////////////////////////////////////////////
// include
#include <geometry/base/CBone.h>
#include <geometry/base/types.h>

namespace geometry
{
    class CKeyframe
    {
    protected:
        std::map<CBone *, Matrix> m_matrices;

    public:
        CKeyframe();
        CKeyframe(const CKeyframe &other);
        CKeyframe(CBone *bone);
        ~CKeyframe();

        CKeyframe operator+(const CKeyframe &other);
        CKeyframe &operator=(const CKeyframe &other);

        void apply();

        std::map<CBone *, Matrix> &getMatrices();
        const std::map<CBone *, Matrix> &getMatrices() const;

    protected:
        void addMatricesFromBone(CBone *bone);

        friend class CAction;
        friend class CModel;
    };
} // namespace geometry

#endif
