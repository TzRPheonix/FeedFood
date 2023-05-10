const nodemailer = require('nodemailer');

async function sendEmail(to, subject, body) {
  const transporter = nodemailer.createTransport({
    host: 'smtp.gmail.com',
    port: 587,
    secure: false,
    auth: {
      user: 'feedfoodynov@gmail.com', // replace with your Gmail address
      pass: 'gevqarbwcjglpedz' // replace with your Gmail password
    }
  });

  const mailOptions = {
    from: 'feedfoodynov@gmail.com', // replace with your Gmail address
    to: to,
    subject: subject,
    html: body
  };

  await transporter.sendMail(mailOptions);
}

module.exports = { sendEmail };