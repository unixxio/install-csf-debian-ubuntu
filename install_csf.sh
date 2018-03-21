#!/bin/bash
echo ""

rm -rf /usr/src/csf* && rm -rf /etc/csf > /dev/null 2>&1

echo -e -n "[ \e[92mWhich ports would you like to allow? (example: 80,443) \e[39m]: "
read ports

echo -e -n "\n[ \e[92mYou have entered \e[39m]: [ \e[92m${ports} \e[39m]"

csf_question="\n[ \e[92mIs this correct? \e[39m]: "
ask_csf_question=`echo -e $csf_question`

read -r -p "${ask_csf_question} [y/N] " question_response
case "${question_response}" in
    [yY][eE][sS]|[yY])
        # do nothing
        ;;
    *)
        exit
        ;;
    *)
esac

echo -e "\n[ \e[92mWaiting while installation is being completed ... \e[39m]"

# download and install csf
cd /usr/src > /dev/null 2>&1
rm -fv csf.tgz > /dev/null 2>&1
wget -q https://download.configserver.com/csf.tgz > /dev/null 2>&1
tar -xzf csf.tgz > /dev/null 2>&1
cd csf > /dev/null 2>&1
sh install.sh > /dev/null 2>&1

# remove comments from csf.conf to increase readability
mv /etc/csf/csf.conf /etc/csf/csf.conf.tmp
cat /etc/csf/csf.conf.tmp | grep -v "#" | awk /./ > /etc/csf/csf.conf

# set variable to grep default allowed ports
TCP_IN=`cat /etc/csf/csf.conf | grep "TCP_IN" | awk {'print $3'} | tr -d '"'`
TCP6_IN=`cat /etc/csf/csf.conf | grep "TCP6_IN" | awk {'print $3'} | tr -d '"'`

# change default allowed ports to default_ports set earlier
sed -i "s/${TCP_IN}/${ports}/g" /etc/csf/csf.conf
sed -i "s/${TCP6_IN}/${ports}/g" /etc/csf/csf.conf

# disable testing mode
sed -i -e 's#TESTING = "1"#TESTING = "0"#g' /etc/csf/csf.conf

# reload csf
csf -r > /dev/null 2>&1

echo -e -n "\n[ \e[92mCSF is now installed \e[39m]"

# empty line
echo ""

# exit installation
exit
