<?php 

// var_dump($adm_email);

$name = $_POST['name'];
$tel = $_POST['tel'];
$email = $_POST['email'];
$comment = $_POST['enquiry'];
$config_email = $_POST['config_email'];

require_once('PHPMailerAutoload.php');
$mail = new PHPMailer;
$mail->CharSet = 'utf-8';

//$mail->SMTPDebug = 3;                               // Enable verbose debug output

$mail->isSMTP();                                      // Set mailer to use SMTP
$mail->Host = 'smtp.mail.ru';  // Specify main and backup SMTP servers
$mail->SMTPAuth = true;                               // Enable SMTP authentication
$mail->Username = 'self67@list.ru';                 // Наш логин
$mail->Password = 'qwe123';                           // Наш пароль от ящика

$mail->SMTPSecure = 'ssl';                            // Enable TLS encryption, `ssl` also accepted
$mail->Port = 465;                                    // TCP port to connect to
 
$mail->setFrom('self67@list.ru', 'Toys Shop');   // От кого письмо 
$mail->addAddress($config_email);     // Add a recipient
// $mail->addCC('seltor@mail.ru');

//$mail->addCC($email);

//$mail->addAddress('ellen@example.com');               // Name is optional
//$mail->addReplyTo('info@example.com', 'Information');
//$mail->addCC('cc@example.com');
//$mail->addBCC('bcc@example.com');
//$mail->addAttachment('/var/tmp/file.tar.gz');         // Add attachments
//$mail->addAttachment('/tmp/image.jpg', 'new.jpg');    // Optional name
$mail->isHTML(true);                                  // Set email format to HTML

$mail->Subject = 'Новая заявка из формы';
$mail->Body    = '
	Пользователь оставил данные <br> 
	Имя: ' . $name . '<br>  
	Телефон: ' . $tel . '<br>  
	Эл почта: ' . $email . ' <br> 
	Админ магазина: '. $config_email .'<br> 
	Коммент: ' . $comment . ' <br> ';

$mail->AltBody = 'Это альтернативный текст';


$mail->Send();

/*
if(!$mail->send()) {
    return false;
} else {
    return true;
}
  */
$mail->clearAddresses();
$mail->addAddress($email);

$mail->Subject = 'Заявка с сайта ...';
$mail->Body = 'Ваша заявка успешно оставлена';

if(!$mail->send()) {
    return false;
} else {
    return true;
}




?>



