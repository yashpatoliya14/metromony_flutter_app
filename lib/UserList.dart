import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metromony/UserForm.dart';
import 'package:metromony/standard.dart';
import './Crud.dart';
class UserList extends StatefulWidget {
  User? _user;
  UserList({super.key,required user}){
    _user =user;
    print(user);
  }

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(itemBuilder: (BuildContext context , int index){
        return getListItem(index);
      },itemCount: widget._user!.userList.length,),
    );
  }

  Widget getListItem(index){
    return Card(
      elevation: 10,
      child: ListTile(
        onTap: () {
          Navigator.of(context).push( MaterialPageRoute(
            builder: (context) {
              print("GO to update");
              return UserForm(userDetail:widget._user!.userList[index],);
            },
          )).then((value) {
            widget._user!.updateUser(map: value, id: index);
            setState(() {});
          });
        },
        leading: Icon(Icons.abc),
        trailing: Wrap(
          alignment: WrapAlignment.center,
          direction: Axis.horizontal,
          children: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: Text('DELETE'),
                      content: Text('Are you sure want to delete?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            widget._user!.deleteUser(id:index);
                            Navigator.pop(context);
                            setState(() {});
                          },
                          child: Text('yes'),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text('No'),
                        )
                      ],
                    );
                  },
                );
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
                size: 25,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey.shade500,
            ),
          ],
        ),
        title: Wrap(
          direction: Axis.vertical,
          children: [
            Text(
              '${widget._user!.userList[index][FIRSTNAME]}',
              style: TextStyle(fontSize: 25, color: Colors.black),
            ),
            Text(
              '${widget._user!.userList[index][CITY]} | ${widget._user!.userList[index][EMAIL]}',
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
          ],
        ),
      ),
    );

  }
}
