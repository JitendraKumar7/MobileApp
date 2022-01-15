import 'package:app_review/app_review.dart';
import 'package:emoji_feedback/emoji_feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info/package_info.dart';
import 'package:share/share.dart';
import 'package:tally/app/app.dart';
import 'package:tally/profile/profile.dart';
import 'package:tally/web/web_view.dart';

import 'avatar.dart';

void supportDialog(BuildContext context) {
  //Help & Support
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
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('CALL - +91 9611223344'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('MAIL - contact@tallykonnect.com'),
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

void feedbackDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      var size = MediaQuery.of(context).size;
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
                      fontSize: 24,
                      wordSpacing: 3,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  padding: const EdgeInsets.all(12),
                  alignment: Alignment.center,
                ),
                const SizedBox(height: 6),
                EmojiFeedback(
                  onChange: (index) => currentIndex = index,
                  availableWidth: size.width - 48,
                ),
                const SizedBox(height: 18),
                TextFormField(
                  maxLines: 9,
                  minLines: 2,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: 'Message',
                  ),
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
                        onPressed: () {
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
        DrawerHeader(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.blue.shade700,
              Colors.blue.shade500,
              Colors.blue.shade100,
            ]),
          ),
          child: Wrap(children: [
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
                    style: const TextStyle(color: Colors.white),
                  ),
                ]),
          ]),
        ),
        const Divider(),
        ListTile(
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(context, WebViewPage.page('About App'));
          },
          title: const Text('About App'),
          leading: const Icon(Icons.info),
          trailing: const Icon(Icons.keyboard_arrow_right),
        ),
        const Divider(),
        ListTile(
          onTap: () {
            Navigator.of(context).pop();
            var page = ProfilePage.page();
            Navigator.push(context, page);
          },
          title: const Text('Profile'),
          leading: const Icon(Icons.person),
          trailing: const Icon(Icons.keyboard_arrow_right),
        ),
        const Divider(),
        ListTile(
          onTap: () {
            Navigator.of(context).pop();
            Share.share(
              'Hii Download TallyKonnectApp',
              subject: 'App Share',
            );
          },
          title: const Text('Share App'),
          leading: const Icon(Icons.share),
          trailing: const Icon(Icons.keyboard_arrow_right),
        ),
        const Divider(),
        ListTile(
          onTap: () {
            Navigator.of(context).pop();
            feedbackDialog(context);
          },
          title: const Text('Feedback'),
          leading: const Icon(Icons.feedback),
          trailing: const Icon(Icons.keyboard_arrow_right),
        ),
        const Divider(),
        ListTile(
          onTap: () {
            Navigator.of(context).pop();
            supportDialog(context);
          },
          title: const Text('Help & Support'),
          leading: const Icon(Icons.support_agent),
          trailing: const Icon(Icons.keyboard_arrow_right),
        ),
        const Divider(),
        ListTile(
          onTap: () {
            Navigator.of(context).pop();
            AppReview.storeListing;
          },
          title: const Text('Rate & Review'),
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
          title: const Text('Logout'),
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
                  '$appName - $version',
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
