// Pegasus Frontend
// Copyright (C) 2017-2020  Mátyás Mustoha
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


#include "SteamCommon.h"

#include "Paths.h"

#include <QFileInfo>
#include <QStringBuilder>


namespace providers {
namespace steam {

#ifdef Q_OS_LINUX
QLatin1String flatpak_pkg_name() {
    return QLatin1String("com.valvesoftware.Steam");
}

bool has_flatpak_flavor_installed() {
    const QString flatpak_bin_subpath = QLatin1String("/flatpak/exports/bin/") % flatpak_pkg_name();
    const QString flatpak_bin_global = QLatin1String("/var/lib") % flatpak_bin_subpath;
    const QString flatpak_bin_local = paths::homePath() % QLatin1String("/.local/share/") % flatpak_bin_subpath;
    return QFileInfo::exists(flatpak_bin_local) || QFileInfo::exists(flatpak_bin_global);
}
#endif

} // namespace steam
} // namespace providers
