const functions = require("firebase-functions");
const nodemailer = require("nodemailer");
const cors = require("cors")({origin: true});

// Configuration SMTP
const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: process.env.SMTP_USER,
    pass: process.env.SMTP_PASSWORD,
  },
});

// Middleware pour valider les requêtes
const validateRequest = (req, res) => {
  if (req.method !== "POST") {
    res.status(405).send("Method Not Allowed");
    return false;
  }

  if (!req.body.nom || !req.body.message) {
    res.status(400).json({error: "Nom et message sont requis"});
    return false;
  }

  return true;
};

// Fonction pour La Petite Fée Crochette
exports.sendToCrochette = functions.https.onRequest(async (req, res) => {
  cors(req, res, async () => {
    if (!validateRequest(req, res)) return;

    try {
      await transporter.sendMail({
        from: "\"La Petite Fée Crochette\" <lapetitefeecrochette@gmail.com>",
        to: "lapetitefeecrochette@gmail.com",
        subject: `Nouveau message de ${req.body.nom}`,
        text: `De: ${req.body.email || "Pas d'email fourni"}\n\n` +
              `Message: ${req.body.message}`,
        replyTo: req.body.email || undefined,
      });

      res.status(200).json({success: true});
    } catch (error) {
      functions.logger.error("Erreur:", error);
      res.status(500).json({
        error: "Échec de l'envoi",
        details: error.message,
      });
    }
  });
});

// Fonction pour Les Petites Créas
exports.sendToCreas = functions.https.onRequest(async (req, res) => {
  cors(req, res, async () => {
    if (!validateRequest(req, res)) return;

    try {
      await transporter.sendMail({
        from:
        "\"Les Petites Créas d'Alexia\" <lespetitescreasdalexia@gmail.com>",
        to: "lespetitescreasdalexia@gmail.com",
        subject: `Nouveau message de ${req.body.nom}`,
        text: `De: ${req.body.email || "Pas d'email fourni"}\n\n` +
              `Message: ${req.body.message}`,
        replyTo: req.body.email || undefined,
      });

      res.status(200).json({success: true});
    } catch (error) {
      functions.logger.error("Erreur:", error);
      res.status(500).json({
        error: "Échec de l'envoi",
        details: error.message,
      });
    }
  });
});
