const ip = '192.168.99.100';
final Uri registerUrl = Uri.parse('http://$ip/api/auth/register');
final Uri consirmationUrl = Uri.parse('http://$ip/api/email/confirm');
final Uri loginUrl = Uri.parse('http://$ip/api/auth/login');
final Uri logoutUrl = Uri.parse('http://$ip/api/auth/logout');
final Uri eventUrl = Uri.parse('http://$ip/api/events');
final Uri myEventUrl = Uri.parse('http://$ip/api/my-events');
