Name:           tigeros-scripts
Version:        1.0
Release:        6%{?dist}
Summary:        TigerOS RIT courses setup scripts

License:        GPLv3
URL:            https://github.com/RITlug/tigeros-scripts
Source0:        %{name}-%{version}-%{release}.tar.gz

BuildArch:      noarch
Requires:       bash

%description
Custom scripts for the TigerOS Fedora Remix that
install packages for specific majors within RIT.

%prep
%setup -q

%install
%{__mkdir_p} %{buildroot}/etc/skel/.config/autostart/
install -p -m 644 tigeros-postinstall.desktop %{buildroot}/etc/skel/.config/autostart/tigeros-postinstall.desktop
%{__mkdir_p} %{buildroot}%{_prefix}/local/bin
install -p -m 755 removal %{buildroot}%{_prefix}/local/bin/removal
install -p -m 755 postinstall %{buildroot}%{_prefix}/local/bin/postinstall
%{__mkdir_p} %{buildroot}%{_prefix}/local/bin/cs
install -p -m 755 cs/idea.sh %{buildroot}%{_prefix}/local/bin/cs/idea.sh
%{__mkdir_p} %{buildroot}%{_prefix}/local/bin/se
install -p -m 755 se/alloy.sh %{buildroot}%{_prefix}/local/bin/se/alloy.sh
install -p -m 755 se/spin.sh %{buildroot}%{_prefix}/local/bin/se/spin.sh

%files
%{_prefix}/local/bin/removal
%{_prefix}/local/bin/postinstall
%{_prefix}/local/bin/cs/
%{_prefix}/local/bin/cs/idea.sh
%{_prefix}/local/bin/se/
%{_prefix}/local/bin/se/alloy.sh
%{_prefix}/local/bin/se/spin.sh
/etc/skel/.config/autostart/tigeros-postinstall.desktop

%changelog
* Wed Oct 17 2018 Tim Zabel <tjz8659@rit.edu> - 1.0-6
- Fedora 29 Build
- Updated install scripts

* Sat Jul 07 2018 Tim Zabel <tjz8659@rit.edu> - 1.0-5
- Updated postinstall, removal scripts
- Removed jflap, logisim scripts

* Sun Apr 01 2018 Tim Zabel <tjz8659@rit.edu> - 1.0-4
- Updated syntax
- Changed summary
