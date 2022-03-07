import 'package:app_review/app_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info/package_info.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tally/app/app.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/profile/profile.dart';
import 'package:tally/services/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../about/about.dart';
import 'avatar.dart';

void supportDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      var size = MediaQuery.of(context).size;
      return Dialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        insetPadding: EdgeInsets.zero,
        child: SizedBox(
          width: size.width - 24,
          child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(12),
              children: [
                Container(
                  child: const Text(
                    'HELP & SUPPORT',
                    style: TextStyle(
                      fontSize: 24,
                      wordSpacing: 3,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  padding: const EdgeInsets.all(12),
                  alignment: Alignment.center,
                ),
                const SizedBox(height: 18),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    launch('tel:+918375938947');
                  },
                  child: const Text('CALL - +91 8375938947'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    var title = 'HELP & SUPPORT';
                    var email = 'info@tallykonnect.com';
                    launch('mailto:$email?subject=$title&body=$title');
                  },
                  child: const Text('MAIL - info@tallykonnect.com'),
                ),
                Container(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('DISMISS'),
                  ),
                  alignment: Alignment.centerRight,
                )
              ]),
        ),
      );
    },
  );
}

void feedbackDialog(BuildContext context, String id) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      var size = MediaQuery.of(context).size;
      var modal = FeedbackModal();
      int currentIndex = 2;
      return Dialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        insetPadding: EdgeInsets.zero,
        child: SizedBox(
          width: size.width - 24,
          child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(12),
              children: [
                Container(
                  child: const Text(
                    'SHARE YOUR FEEDBACK',
                    style: TextStyle(
                      fontSize: 18,
                      wordSpacing: 3,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  padding: const EdgeInsets.all(12),
                  alignment: Alignment.center,
                ),
                const SizedBox(height: 18),
                TextFormField(
                  maxLines: 9,
                  minLines: 2,
                  keyboardType: TextInputType.multiline,
                  onChanged: (value) => modal.message = value,
                  controller: TextEditingController(text: modal.message),
                  decoration: const InputDecoration(labelText: 'Message'),
                ),
                const SizedBox(height: 18),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(width: 36),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('CANCEL'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          modal.userId = id;
                          db.feedback.add(modal);

                          const snackBar = SnackBar(
                            content: Text('Feedback Submitted Successfully'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          debugPrint('Index $currentIndex');
                          Navigator.of(context).pop();
                        },
                        child: const Text('SUBMIT'),
                      ),
                    ]),
              ]),
        ),
      );
    },
  );
}

class DrawerLayout extends StatelessWidget {
  const DrawerLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<AppBloc>();
    final user = bloc.state.user;
    return Drawer(
      child: ListView(children: [
        Container(
          padding: const EdgeInsets.only(top: 12, bottom: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.blue.shade700,
              Colors.blue.shade500,
              Colors.blue.shade100,
            ]),
          ),
          child: Column(children: [
            Avatar(photo: user.photo),
            const SizedBox(width: 12),
            Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name ?? '',
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    user.email ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ]),
          ]),
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(context, AboutPage.page());
          },
          title: const Text(
            'About App',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: const Icon(Icons.info),
          trailing: const Icon(Icons.keyboard_arrow_right),
        ),
        const Divider(),
        ListTile(
          onTap: () {
            Navigator.of(context).pop();
            var page = ProfilePage.page(user.id);
            Navigator.push(context, page);
          },
          title: const Text(
            'Profile',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: const Icon(Icons.person),
          trailing: const Icon(Icons.keyboard_arrow_right),
        ),
        const Divider(),
        ListTile(
          onTap: () {
            Navigator.of(context).pop();
            Share.share(
              shareMessage,
              subject: 'App Share',
            );
          },
          title: const Text(
            'Share App',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: const Icon(Icons.share),
          trailing: const Icon(Icons.keyboard_arrow_right),
        ),
        const Divider(),
        ListTile(
          onTap: () {
            Navigator.of(context).pop();
            feedbackDialog(context, user.id);
          },
          title: const Text(
            'Feedback',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: const Icon(Icons.feedback),
          trailing: const Icon(Icons.keyboard_arrow_right),
        ),
        const Divider(),
        ListTile(
          onTap: () {
            Navigator.of(context).pop();
            supportDialog(context);
          },
          title: const Text(
            'Help & Support',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: const Icon(Icons.support_agent),
          trailing: const Icon(Icons.keyboard_arrow_right),
        ),
        const Divider(),
        ListTile(
          onTap: () {
            Navigator.of(context).pop();
            AppReview.storeListing;
          },
          title: const Text(
            'Rate & Review',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: const Icon(Icons.reviews),
          trailing: const Icon(Icons.keyboard_arrow_right),
        ),
        const Divider(),
        ListTile(
          onTap: () {
            Navigator.of(context).pop();
            var bloc = context.read<AppBloc>();
            bloc.add(AppLogoutRequested());
          },
          title: const Text(
            'Logout',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: const Icon(Icons.logout),
          trailing: const Icon(Icons.keyboard_arrow_right),
        ),
        const Divider(),
        FutureBuilder(
          future: PackageInfo.fromPlatform(),
          builder: (_, AsyncSnapshot<PackageInfo> snapshot) {
            if (snapshot.hasData) {
              var packageInfo = snapshot.data;
              var appName = packageInfo?.appName;
              var version = packageInfo?.version;
              var packageName = packageInfo?.packageName;
              var buildNumber = packageInfo?.buildNumber;
              debugPrint('$packageName $buildNumber');
              return Container(
                padding: const EdgeInsets.only(right: 24),
                alignment: Alignment.centerRight,
                child: Text(
                  '$appName - $version - $buildNumber',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              );
            }
            return const SizedBox();
          },
        )
      ]),
    );
  }
}
