color="\e[33m"
no_color="\e[0m"

echo -e "$color copy payment service file $no_color"
cp payment.service /etc/systemd/system/payment.service

echo -e "$color install python $no_color"
dnf install python3 gcc python3-devel -y

echo -e "$color Add user application user $no_color"
useradd roboshop

echo -e "$color create Application Directory $no_color"
rm -rf /app
mkdir /app 

echo -e "$color Download Application content $no_color"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment-v3.zip 
cd /app 

echo -e "$color Extract Application content $no_color"
unzip /tmp/payment.zip

echo -e "$color Download application dependencies $no_color"
 pip3 install -r requirements.txt

echo -e "$color Start application service $no_color"
systemctl daemon-reload
systemctl enable payment 
systemctl restart payment