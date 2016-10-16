# Installs all necessary dependencies for the project
echo "Checking if all necessary dependecies are installed..."

# Detects which Linux distribution is being used.
echo "Checking if LAMP stack is installed..." && (cat /proc/version | grep ubuntu &> /dev/null && echo "You have Ubuntu ")

# Ubuntu installation
# Checks if LAMP stack is installed.
# Checks if Apache is installed.
sudo dpkg -l | grep apache2 &> /dev/null && echo "Apache has been installed!" || (echo "Installing Apache now..." && sudo apt-get install -y apache2 &> /dev/null)

# Checks if PHP mod for Apache is installed
(sudo dpkg -l | grep installed | grep libapache2-mod-php5 &> /dev/null) || (sudo dpkg --list | grep installed | grep libapache2-mod-php) && echo "Apache has PHP enabled..." || (echo "Enabling PHP for Apache now..." && (sudo apt-get -y install libapache2-mod-php5 &> /dev/null || sudo apt-get -y install libapache2-mod-php &> /dev/null))

# Checks if MySQL is installed
sudo dpkg -l | grep mysql-server &> /dev/null && echo "MySQL server is already installed..." || (echo "Installing MySQL server now..." && sudo apt-get -y install mysql-server &>/dev/null)

sudo dpkg -l php5-mysql &> /dev/null && echo "MySQL PHP has already been installed..." || (echo "Installing MySQL PHP now..." && (sudo apt-get -y install php5-mysql &> /dev/null || sudo apt-get -y install php-mysql &> /dev/null))

# Checks if PHP is installed
sudo dpkg -l | grep php &> /dev/null && echo "PHP is already installed..." || (echo "Installing PHP now..." && (sudo apt-get -y install php &> /dev/null || sudo apt-get -y php5 &> /dev/null))

# Checks if Node.js is installed
dpkg -l | grep node &> /dev/null && echo "Node.js is installed!" || (sudo apt-get install -y npm &> /dev/null && echo "Node.js has been installed!" || (echo "Node.js was not properly installed. Aborting..." && exit 1))

# Creates a symbolic link to prevent errors
([ ! -h /usr/bin/node ] && sudo ln -s /usr/bin/nodejs /usr/bin/node &> /dev/null && echo "Symbolic link between nodejs and node has been made.") || echo "Symbolic link currently exists between nodejs and node."

# Checks that Gulp is installed globally
npm list -g | grep gulp &> /dev/null && echo "Gulp is installed!" || (sudo npm install gulp -g &> /dev/null && echo "Gulp has been installed!" || (echo "Gulp was not properly installed. Aborting..." && exit 1))

# Checks that npm-check-updates is installed globally
npm list -g | grep npm-check-updates &> /dev/null && echo "Automatic upgrading of Node.js dependencies is installed." || (sudo npm install npm-check-updates -g &> /dev/null && echo "Node.js dependencies will can now be upgraded automatically." || (echo "npm-check-updates was not properly installed. Aborting..." && exit 1))

# For any OS.
# Check for updates to package.json, then installs dependencies and updates them.
(ncu -u &> /dev/null && echo "Any upgrades necessary have been made to package.json.") && (sudo npm install &> /dev/null && echo "Installed all package dependencies!" && npm update &> /dev/null && echo "Done preparing environment for working on project!") || (echo "Something went wrong with installing packages. Aborting..." && exit 1)
