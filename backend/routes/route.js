require('dotenv').config();
const express = require('express');
const router = express.Router();
const userModel = require('../models/userModel');
const postModel = require('../models/postModel');
const { sendEmail } = require('../services/user');
const crypto = require('crypto');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

//Post Method pour un compte
router.post('/register', async (req, res) => {
    console.log(req.body)
    notHasedPassword = req.body.password
    const hashedPassword = await bcrypt.hash(notHasedPassword, 10);
    const newUser = new userModel({
        username: req.body.username,
        email: req.body.email,
        password: hashedPassword
    })
    try {
        const savedUser = await newUser.save();
        res.status(200).json(savedUser)
    }
    catch (error) {
        res.status(400).json({message: error.message})
    }
})

//Get all Method
router.get('/getAll', async (req, res) => {
    try {
        const data = await userModel.find();
        res.json(data)
    }
    catch (error) {
        res.status(500).json({ message: error.message })
    }
})

router.post('/login', async (req, res) => {
    const { email, password } = req.body;
    try {
      const user = await userModel.findOne({ email });
  
      if (!user) {
        return res.status(401).json({ message: 'Utilisateur introuvable.' });
      }
      console.log('user.password:', user.password);
      console.log('password:', password);
      const match = await bcrypt.compare(password, user.password);
      console.log(match)
      if (match) {
        const token = jwt.sign({ userId: user._id }, process.env.JWT_SECRET, { expiresIn: '168h' });
        return res.status(200).json({ message: 'Authentification réussie.', token});
      } else {
        return res.status(401).json({ message: 'Authentification échouée.' });
      }
    } catch (error) {
      return res.status(500).json({ message: error.message });
    }
});
  
  
  
//Password Reset Request Method
router.post('/reset-password', async (req, res) => {
  try {
      const email = req.body.email;
      const user = await userModel.findOne({ email });
      if (!user) {
          return res.status(404).json({ message: 'User not found' });
      }
      // Generate a password reset token and store it in the user object
      const token = crypto.randomBytes(20).toString('hex');
      user.resetToken = token;
      user.resetTokenExpires = Date.now() + 3600000; // Token expires in 1 hour
      await user.save();
      // Send the password reset email with the reset link
      const resetLink = `https://example.com/reset-password/${token}`;
      const emailBody = `Click on this link to reset your password: ${resetLink}`;
      await sendEmail(email, 'Password Reset', emailBody); // <-- change this line
      res.status(200).json({ message: 'Password reset email sent' });
  } catch (error) {
      res.status(500).json({ message: error.message });
  }
})

//Password Reset Link Method
router.patch('/reset-password/:token', async (req, res) => {
  try {
    const token = req.params.token;
    const user = await userModel.findOne({ resetToken: token, resetTokenExpires: { $gt: Date.now() } });
    if (!user) {
      return res.status(404).json({ message: 'Invalid or expired token' });
    }
    const { password } = req.body;
    if (!password) {
      return res.status(400).json({ message: 'Password is required' });
    }
    user.password = password;
    user.resetToken = undefined;
    user.resetTokenExpires = undefined;
    await user.save();
    res.status(200).json({ message: 'Password reset successful' });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});


//Delete by ID Method
router.delete('/delete/:id', (req, res) => {
    res.send('Delete by ID API')
})

//Créer un post
router.post('/addPost', async (req, res) => {
  console.log(req.body)
  try {
    // Find the user by id
    const user = await userModel.findById(req.body.createdBy);
    if (!user) {
      // If user not found, return an error response
      return res.status(400).json({ message: 'Invalid user id' });
    }

    // Create a new post document
    const post = new postModel({
      title: req.body.title,
      image: req.body.image,
      description: req.body.description,
      createdBy: user._id // Use the user's ObjectId
    });

    // Save the post document
    const savedPost = await post.save();

    res.status(200).json(savedPost);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
});

//Methode avoir tous les post
router.get('/posts', async (req, res) => {
  try {
    const posts = await postModel.find().populate('createdBy', 'username').exec();
    res.json(posts);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});


//Methode avoir les posts d'un utilisateur avec son id
router.get('/userpost/:id', async (req, res) => {
  try {
    const posts = await postModel.find({ createdBy: req.params.id }).populate('createdBy', 'username').exec();
    if (!posts || posts.length === 0) {
      return res.status(404).json({ message: 'No posts found for this user' });
    }
    res.json(posts.map(post => ({
      _id: post._id,
      title: post.title,
      image: post.image,
      description: post.description,
      username: post.createdBy.username
    })));
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});


module.exports = router;