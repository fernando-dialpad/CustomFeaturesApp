var express = require('express');
var router = express.Router();

router.post('/login', function(req, res, next) {
  const username = req.body.username;
  const password = req.body.password;
  if(username != 'myusername' || password != 'mypassword') {
    res.status(404).json({});
    return;
  }
  res.json(
    {
      id: "823B58D1-B93F-4BA9-AFD8-958285A6D8E9",
      firstName: "Fernando",
      lastName: "del Rio",
      phone: "(408) 664-0019",
      email: "fernando.rio@dialpad.com",
      address: "Some address",
      photo: "https://lh3.googleusercontent.com/JwBQ-W0o9UwCLvcmHy26MaDbXHuX02YyQFuhkpqIyggpU7F0M3v0akAWHoblo8v44zjRwfBkITUiS8oUnDnweMYTWeJDcl8QcuE=s192-c",
      statusMessage: "No status message",
      jobTitle: "iOS Engineer",
      contacts: []
    }
  )
});

router.get('/contacts/:userid', function(req, res, next) {
  const userid = req.params.userid;
  if(userid != '823B58D1-B93F-4BA9-AFD8-958285A6D8E9') {
    res.status(404).json({});
    return;
  }
  res.json([
    {
      id: "7A9FD4BE-F63F-42A7-8ACB-D417F36830F8",
      firstName: "Trevor",
      lastName: "Jones",
      phone: "+1 647-495-6847",
      email: "trevor.jones@dialpad.com",
      address: "Some address",
      photo: "https://lh3.googleusercontent.com/norwPhpMprd87v7VZ_p9ZvstOokEOQv4TIMeG8qZQoR1DhPvX5SFBHFzktip79VzMNoKm-vDFshjQJU1FDliz8s=s192-c",
      statusMessage: "No status message",
      jobTitle: "iOS Engineer",
      contacts: []
    },
    {
      id: "87C1DC58-AD05-4FF5-BBDF-9948D4E3187E",
      firstName: "Michael",
      lastName: "Friedman",
      phone: "(408) 214-4320",
      email: "michael.friedman@dialpad.com",
      address: "Some address",
      address: "",
      photo: "https://lh3.googleusercontent.com/wuCNd41LhUZEpU-gakMu1PQ0_s8iK0ySE9XeYHg4RJAuZokd77kF3_ZdyHIQZr45rz3vlZnhFi1Ti30WEpjj0evnOLwcTeI2zxE=s192-c",
      statusMessage: "No status message",
      jobTitle: "iOS Engineer",
      contacts: []
    },
    {
      id: "641E15C4-3CE5-4CEF-963C-5E9F386D40FA",
      firstName: "Henrique",
      lastName: "Lima",
      phone: "(415) 805-2326",
      email: "henrique.lima@dialpad.com",
      address: "Some address",
      photo: "https://lh3.googleusercontent.com/X3dBlvlEKhAx4xzkD-YSK6u95CAjYNG7AR4wvRAt7UcQCjSjXwQtwuY_htvrxNWpFVpsY_vs2W1R9LibyJdu61IXlvmXU1_syA=s192-c",
      statusMessage: "No status message",
      jobTitle: "iOS Engineer",
      contacts: []
    },
    {
      id: "5E2101D4-53D8-4F2E-8751-73BE4A51740D",
      firstName: "Dave",
      lastName: "Ingle",
      phone: "+1 604-262-9230",
      email: "dingle@dialpad.com",
      address: "Some address",
      photo: "https://lh3.googleusercontent.com/yRrheuiaIcMfLZ5-aOfIQecrgwHEn-ctJCY5FFHN0ySRqLyL8eUL6sLEVIk2i7unZNpTllIE55tFAvdvmGtYGEU=s192-c",
      statusMessage: "No status message",
      jobTitle: "iOS Engineer",
      contacts: []
    },
    {
      id: "7A9FD4BE-F63F-42A7-8ACB-D417F36830F8",
      firstName: "Shawn",
      lastName: "Burlew",
      phone: "(719) 602-0990",
      email: "shawn.burlew@dialpad.com",
      address: "Some address",
      photo: "https://lh3.googleusercontent.com/zWhfFMhLGCbK85Aq5SA1mB7GQPuqH-OBoz2XtwD999JTRCN8zzkedU2JnQU9XgzxH1P5uN1K2KstrTULrb94rw=s192-c",
      statusMessage: "No status message",
      jobTitle: "iOS Engineer",
      contacts: []
    },
    {
      id: "BD67188A-41E3-42B3-BE43-D5847F3FB2CA",
      firstName: "Chibundu",
      lastName: "Anwuna",
      phone: "+1 604-334-9503",
      email: "chibundu.anwuna@dialpad.com",
      address: "Some address",
      photo: "https://lh3.googleusercontent.com/otk5vXjlXd7OrPkYBd15HQC8Po27d9cqT8BKllMbUCGgQJbmOYaU3O-PCRYeTzDLgrpSJ9ACoS6WjQEYTk1tjDYFEugAsGYsKA=s192-c",
      statusMessage: "No status message",
      jobTitle: "iOS Engineer",
      contacts: []
    },
    {
      id: "7199DA7E-3510-42D6-BF9F-43728E36883A",
      firstName: "Dan",
      lastName: "Carlson",
      phone: "+1 226-778-8919",
      email: "dan.carlson@dialpad.com",
      address: "Some address",
      photo: "https://lh3.googleusercontent.com/7AN0Y5snjEM7JoM0jGiAZM_tjEmO3pR2J6fJmWN0phWPt4rt4y3a7Ei-4T2UxF12R874teqHJX7cQUW5WR8iXeGp5J7vMRnSrA=s192-c",
      statusMessage: "No status message",
      jobTitle: "iOS Engineer",
      contacts: []
    },
    {
      id: "432A60D5-D95A-406A-BF61-56F665D30DFB",
      firstName: "Jeff",
      lastName: "Pedersen",
      phone: "+1 226-212-2244",
      email: "jeff.pedersen@dialpad.com",
      address: "Some address",
      photo: "https://lh3.googleusercontent.com/4Q2CS6VeQxbo92fR-1DUyoYmEugqhvvKvC9yZe_ecGbQr0HnlNP_qTDXfDfIOmtaN1f41ceRcoG2mvhAg9gdPG2WInL6gnp-fZU=s192-c",
      statusMessage: "No status message",
      jobTitle: "iOS Engineer",
      contacts: []
    },
    {
      id: "4A215FC5-EFC8-4BBF-A3BF-25DDBA4D1E98",
      firstName: "German",
      lastName: "Azcona",
      phone: "(510) 439-9327",
      email: "german.azcona@dialpad.com",
      address: "Some address",
      photo: "https://lh3.googleusercontent.com/iqoCStFeOpK06oQuY57qqks0Yo6nz7tIX0JRoq04R14CeG8Wh7VTgXvHbgoKoePY2usoMRsnph6Pl9cBS3iNWlextqHFOEq7cA=s192-c",
      statusMessage: "No status message",
      jobTitle: "iOS Engineer",
      contacts: []
    },
    {
      id: "94060C7B-7688-47D8-93C8-6D6AEC23D65B",
      firstName: "Joe",
      lastName: "Ferrucci",
      phone: "(408) 381-3186",
      email: "joe.ferrucci@dialpad.com",
      address: "Some address",
      photo: "https://lh3.googleusercontent.com/MIhRgZuyTqFQ7nzerF6PWcjnOFIg7A2hPQPDVqb4rehNAY22pVQkNaeQn1ikLmRa5BYHXWzbhgzBTjHcgf7dAMH1Hl1KORSDi2nL=s192-c",
      statusMessage: "No status message",
      jobTitle: "iOS Engineer",
      contacts: []
    },
    {
      id: "D9AEA5E8-6E87-4E85-B3E2-1D54231D8FC8",
      firstName: "Taryn",
      lastName: "Weiss",
      phone: "+1 647-557-9289",
      email: "taryn.weiss@dialpad.com",
      address: "Some address",
      photo: "https://lh3.googleusercontent.com/_g-AXJY1o81DStzkH2r0cNQ6FE6CeWsWJitBbA1fiPW0s2V7fwT-kizVxfJ13zdBcX8drRfINw59ZZGmewKK-PbzSrTZoOLe60A=s192-c",
      statusMessage: "No status message",
      jobTitle: "iOS Engineer",
      contacts: []
    }
  ])
});

module.exports = router;
