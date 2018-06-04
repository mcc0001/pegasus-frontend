// Pegasus Frontend
// Copyright (C) 2017  Mátyás Mustoha
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.


#pragma once

#include <QHash>
#include <QObject>
#include <QXmlStreamReader>

namespace model { class Collection; }
namespace model { class Game; }


namespace providers {
namespace es2 {

class SystemsParser : public QObject {
    Q_OBJECT
    Q_DISABLE_COPY(SystemsParser)

public:
    SystemsParser(QObject* parent);

    void find(QHash<QString, model::Game*>& games,
              QHash<QString, model::Collection*>& collections);

signals:
    void gameCountChanged(int count);
    void romDirFound(QString dir_path);

private:
    void readSystemsFile(QXmlStreamReader&,
                         QHash<QString, model::Game*>&,
                         QHash<QString, model::Collection*>&);
    void readSystemEntry(QXmlStreamReader&,
                         QHash<QString, model::Game*>&,
                         QHash<QString, model::Collection*>&);
};

} // namespace es2
} // namespace providers