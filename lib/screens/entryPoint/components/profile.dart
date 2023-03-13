import 'package:flutter/material.dart';
import 'package:goowid_auth/constants.dart';
import 'package:goowid_auth/screens/entryPoint/components/work_card.dart';
import 'package:goowid_auth/widgets/app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // final String _status = "Software Developer";

  final String _bio =
      "\"Hi, I am a Freelance developer working for hourly basis. If you wants to contact me to build your product leave a message.\"";

  final String _onBudget = "80%";

  final String _jobs = "12";

  final String _onTime = "100%";

  late String? title;

  @override
  void initState() {
    super.initState();
    getName();
  }

  String? name;
  String? email;

  getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.getString('displayName') ?? '';
      name = name?.replaceAll(RegExp(r'[^\w\s]+'), '');
      email = name! + '@goowid.com';
    });
  }

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 2.6,
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage('assets/Backgrounds/etz_bg.png'),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          height: 115,
          width: 115,
          child: Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            children: [
              const CircleAvatar(
                backgroundImage:
                    AssetImage("assets/avaters/Avatar Default.jpg"),
              ),
              Positioned(
                  bottom: 0,
                  right: -25,
                  child: RawMaterialButton(
                    onPressed: () {},
                    elevation: 2.0,
                    fillColor: const Color(0xFFF5F6F9),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.grey,
                    ),
                    padding: const EdgeInsets.all(2.0),
                    shape: const CircleBorder(),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _syncLinkedin() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: GestureDetector(
        onTap: () {
          //Navigator.pushNamed(context, linkedIn);
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset(
                'assets/icons/linkedin.png',
                width: 35,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    'Connect your',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    'LinkedIn',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFullName() {
    TextStyle _nameTextStyle = const TextStyle(
      fontFamily: 'Poppins',
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Text(
            name ?? '',
            style: _nameTextStyle,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        const Icon(
          Icons.edit,
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget _buildRating() {
    return RatingBar.builder(
      initialRating: 3,
      minRating: 1,
      itemSize: 30,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }

  Widget _buildLocation() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        children: [
          const Icon(Icons.location_on_sharp),
          const Text('London, UK'),
        ],
      ),
    );
  }

  Widget _buildStatus(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: const Text(
            'Job Title',
            style: TextStyle(
              fontFamily: 'Spectral',
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmail(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            email ?? '',
            style: const TextStyle(
              fontFamily: 'Spectral',
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String count) {
    TextStyle _statLabelTextStyle = const TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeight.w200,
    );

    TextStyle _statCountTextStyle = const TextStyle(
      color: Colors.black54,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count,
          style: _statCountTextStyle,
        ),
        Text(
          label,
          style: _statLabelTextStyle,
        ),
      ],
    );
  }

  Widget _buildStatContainer() {
    return Container(
      height: 60.0,
      margin: const EdgeInsets.only(top: 8.0),
      decoration: const BoxDecoration(
        color: Color(0xFFEFF4F7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildStatItem("Jobs", _jobs),
          _buildStatItem("On Time", _onTime),
          _buildStatItem("On Budget", _onBudget),
        ],
      ),
    );
  }

  Widget _buildBio(BuildContext context) {
    TextStyle bioTextStyle = const TextStyle(
      fontFamily: 'Spectral',
      fontWeight: FontWeight.w400, //try changing weight to w500 if not thin
      fontStyle: FontStyle.italic,
      color: Color(0xFF799497),
      fontSize: 16.0,
    );

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.all(8.0),
      child: Text(
        _bio,
        textAlign: TextAlign.center,
        style: bioTextStyle,
      ),
    );
  }

  Widget _buildExperience(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'My Work',
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.headline2,
      ),
    );
  }

  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.6,
      height: 2.0,
      color: Colors.black54,
      margin: const EdgeInsets.only(top: 4.0),
    );
  }

  // Widget _buildGetInTouch(BuildContext context) {
  //   return Container(
  //     color: Theme.of(context).scaffoldBackgroundColor,
  //     padding: const EdgeInsets.only(top: 8.0),
  //     child: Text(
  //       "Get in Touch with ${_name!.replaceAll(new RegExp(r'[^\w\s]+'), '')}",
  //       style: const TextStyle(fontFamily: 'Roboto', fontSize: 16.0),
  //     ),
  //   );
  // }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () async {
                String email = Uri.encodeComponent("$name@goowid.com");
                String subject = Uri.encodeComponent("Job interest");
                String body = Uri.encodeComponent(
                    "Hi! I'd love to speak with you about a job.");
                print(subject); //output: Hello%20Flutter
                Uri mail =
                    Uri.parse("mailto:$email?subject=$subject&body=$body");
                if (await launchUrl(mail)) {
                  //email app opened
                } else {
                  //email app is not opened
                }
              },
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: brightCoral,
                ),
                child: const Center(
                  child: Text(
                    "HIRE",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: InkWell(
              onTap: () async {
                String email = Uri.encodeComponent("$name@goowid.com");
                String subject = Uri.encodeComponent("Job interest");
                String body = Uri.encodeComponent(
                    "Hi! I'd love to speak with you about a job.");
                print(subject); //output: Hello%20Flutter
                Uri mail =
                    Uri.parse("mailto:$email?subject=$subject&body=$body");
                if (await launchUrl(mail)) {
                  //email app opened
                } else {
                  //email app is not opened
                }
              },
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: brightCoral,
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "MESSAGE",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const ResusableBar(),
      //backgroundColor: Colors.white,
      body: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 9.9),
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              _buildCoverImage(screenSize),
              SafeArea(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: screenSize.height / 6.4),
                    const SizedBox(height: 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildProfileImage(),
                        _syncLinkedin(),
                      ],
                    ),
                    _buildFullName(),
                    _buildLocation(),
                    _buildRating(),
                    _buildStatus(context),
                    _buildEmail(context),
                    const SizedBox(
                      height: 8,
                    ),
                    _buildStatContainer(),
                    const SizedBox(
                      height: 8,
                    ),
                    _buildBio(context),
                    _buildSeparator(screenSize),
                    const SizedBox(height: 10.0),
                    _buildExperience(context),
                    const SizedBox(height: 10.0),
                    // ignore: prefer_const_constructors
                    WorkCard(
                      title: 'Develop mobile application',
                      company: 'Etz Tech',
                      time: '3 weeks',
                      skill: 'Flutter/Dart',
                      skill2: 'Mobile Applications',
                      skill3: 'Firebase',
                    ),
                    const SizedBox(height: 10.0),
                    const WorkCard(
                      title: 'Software Engineer',
                      company: 'Google',
                      time: '5 weeks',
                      skill: 'Flutter/Dart',
                      skill2: 'GCP',
                      skill3: 'Firebase',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: _buildButtons(),
      ),
    );
  }
}
