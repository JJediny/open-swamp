use assessment;
drop PROCEDURE if exists upgrade_12;
DELIMITER $$
CREATE PROCEDURE upgrade_12 ()
  BEGIN
    declare script_version_no int;
    declare cur_db_version_no int;
    set script_version_no = 12;

    select max(database_version_no)
      into cur_db_version_no
      from assessment.database_version;

    if cur_db_version_no < script_version_no then
      begin

        # Add CodeDX Viewer
        insert into viewer_store.viewer (viewer_uuid, viewer_owner_uuid, name, viewer_sharing_status)
          values ('4221533e-865a-11e3-88bb-001a4a81450b', '80835e30-d527-11e2-8b8b-0800200c9a66', 'CodeDX', 'PUBLIC');
        insert into viewer_store.viewer_version (viewer_version_uuid, viewer_uuid,
                            version_string,
                            invocation_cmd, sign_in_cmd, add_user_cmd, add_result_cmd,
                            viewer_path, viewer_checksum,
                            viewer_db_path, viewer_db_checksum)
                    values ('5d0fb63c-865a-11e3-88bb-001a4a81450b', '4221533e-865a-11e3-88bb-001a4a81450b',
                            '1',
                            'invocation_cmd', 'sign_in_cmd', 'add_user_cmd', 'add_result_cmd',
                            'viewer_path', 'viewer_checksum',
                            'viewer_db_path', 'viewer_db_checksum');

        # Add New Pkgs
        insert into package_store.package
        (package_uuid,                           package_owner_uuid,                   name, package_sharing_status) values
        ('b584532d-8a27-11e3-88bb-001a4a81450b','9659c792-8a27-11e3-88bb-001a4a81450b','bodgeit','PUBLIC'),
        ('b65e7bdb-8a27-11e3-88bb-001a4a81450b','a1468dd8-8a27-11e3-88bb-001a4a81450b','esapi-swingset','PUBLIC'),
        ('b72ccdc1-8a27-11e3-88bb-001a4a81450b','a63a4f99-8a27-11e3-88bb-001a4a81450b','mandiant-struts','PUBLIC'),
        ('b8088017-8a27-11e3-88bb-001a4a81450b','a75ecab2-8a27-11e3-88bb-001a4a81450b','owasp-1-liner','PUBLIC'),
        ('b906458e-8a27-11e3-88bb-001a4a81450b','a865972b-8a27-11e3-88bb-001a4a81450b','wavsep','PUBLIC'),
        ('b9e0c4de-8a27-11e3-88bb-001a4a81450b','a96980b8-8a27-11e3-88bb-001a4a81450b','yazd','PUBLIC'),
        ('bac9c99c-8a27-11e3-88bb-001a4a81450b','aa5f87a3-8a27-11e3-88bb-001a4a81450b','autopsy','PUBLIC'),
        ('bbac556e-8a27-11e3-88bb-001a4a81450b','ab2c981c-8a27-11e3-88bb-001a4a81450b','broadleaf','PUBLIC'),
        ('bc8fc4d9-8a27-11e3-88bb-001a4a81450b','ac2a20b2-8a27-11e3-88bb-001a4a81450b','condor','PUBLIC'),
        ('bd6ab38e-8a27-11e3-88bb-001a4a81450b','ad171e52-8a27-11e3-88bb-001a4a81450b','ddf','PUBLIC'),
        ('be468a13-8a27-11e3-88bb-001a4a81450b','ae01a89a-8a27-11e3-88bb-001a4a81450b','jacorb','PUBLIC'),
        ('bf24bfb2-8a27-11e3-88bb-001a4a81450b','afaae50e-8a27-11e3-88bb-001a4a81450b','omniORB','PUBLIC'),
        ('c00d7a12-8a27-11e3-88bb-001a4a81450b','b0870aae-8a27-11e3-88bb-001a4a81450b','openfire','PUBLIC'),
        #('c0f68c0c-8a27-11e3-88bb-001a4a81450b','b163f590-8a27-11e3-88bb-001a4a81450b','openfire','PUBLIC'),
        ('c1bf3274-8a27-11e3-88bb-001a4a81450b','b23a66c2-8a27-11e3-88bb-001a4a81450b','openmpi','PUBLIC'),
        ('c292c02e-8a27-11e3-88bb-001a4a81450b','b317119a-8a27-11e3-88bb-001a4a81450b','R','PUBLIC'),
        ('c36dd4c3-8a27-11e3-88bb-001a4a81450b','b3e32f33-8a27-11e3-88bb-001a4a81450b','webgoat','PUBLIC');

        insert into package_store.package_version
        (package_version_uuid,                   package_uuid,                         version_string,     release_date, comment_public, comment_private,    package_path,                                                                                                    source_path,                              build_needed,  build_file,         build_system,             build_cmd,      build_target,    build_dir,    build_opt,                                         config_cmd,                                                                                  config_opt,                                                                                             config_dir,   custom_shell_cmd, checksum) values
        ('9659c792-8a27-11e3-88bb-001a4a81450b','b584532d-8a27-11e3-88bb-001a4a81450b','1.4.x',            now(),        NULL,           NULL,               '/swamp/store/SCAPackages/UW/bodgeit-1.4.x/bodgeit-read-only.tar.gz',                                           'bodgeit-read-only',                       1,             'build.xml',        'ant',                    NULL,           '',              '.',          NULL,                                              NULL,                                                                                        NULL,                                                                                                   '.',          NULL,            'f9d49e5620972783a5c0a974514c65d8375633c35b8992e45e95b68f654160d2cd53e9686763873f524bc28b8b8641c8439f488664f6cbbb50e5513f9b60cee8'),
        ('a1468dd8-8a27-11e3-88bb-001a4a81450b','b65e7bdb-8a27-11e3-88bb-001a4a81450b','1.0.x',            now(),        NULL,           NULL,               '/swamp/store/SCAPackages/UW/esapi-swingset-1.0.x/owasp-esapi-swingset-interactive.tar.gz',                     'owasp-esapi-swingset-interactive',        1,             'pom.xml',          'maven',                  NULL,           'package',       '.',          NULL,                                              NULL,                                                                                        NULL,                                                                                                   '.',          NULL,            '0aad3edf155a08d7d20db779a9253e1360f5434d307efcab60e8e316bdfe6da996ea4a01a49a7e5af8f236c3eadc752a479964e739b81ceba8c3e67af1f8cbb0'),
        ('a63a4f99-8a27-11e3-88bb-001a4a81450b','b72ccdc1-8a27-11e3-88bb-001a4a81450b','r230',             now(),        NULL,           NULL,               '/swamp/store/SCAPackages/UW/mandiant-struts-r230/mandiant-struts-form-vulnerable.tar.gz',                      'mandiant-struts-form-vulnerable',         1,             'src/build.xml',    'ant',                    NULL,           'compile',       '.',          NULL,                                              NULL,                                                                                        NULL,                                                                                                   '.',          NULL,            '597c8a4f0bf91be2efa4cc133d337399dcff37a18c0afe180a005e92dad2c334021138fc19968facca7d8a22a96498e1bf0b170e513661a2e77563eb814edd46'),
        ('a75ecab2-8a27-11e3-88bb-001a4a81450b','b8088017-8a27-11e3-88bb-001a4a81450b','dd51680d23',       now(),        NULL,           NULL,               '/swamp/store/SCAPackages/UW/owasp-1-liner-dd51680d23/owasp-1-liner-master.tar.gz',                             'owasp-1-liner-master',                    1,             'pom.xml',          'maven',                  NULL,           'package',       '.',          NULL,                                              NULL,                                                                                        NULL,                                                                                                   '.',          NULL,            'a70de7f0049b57a6660e56900d450ec7a5fad07a51668894193c8d3a9e7e0a39a6b49c83381c9eae2fc84037f986292af26c0f4fdd1886a74949ea79453f5296'),
        ('a865972b-8a27-11e3-88bb-001a4a81450b','b906458e-8a27-11e3-88bb-001a4a81450b','1.2',              now(),        NULL,           NULL,               '/swamp/store/SCAPackages/UW/wavsep-1.2/wavsep-v1.2-src-eclipse-archive.tar.gz',                                'wavsep-v1.2-src-eclipse-archive',         1,             'pom.xml',          'maven',                  NULL,           'package',       '.',          NULL,                                              NULL,                                                                                        NULL,                                                                                                   '.',          NULL,            'b0dae5997d9e70f98eea1c983f9f7dd5db9143b1da884cc8b062613150baf85017e6f7edfd0630b1ab973be72023581e201060d103938379de44de7ed9c170e7'),
        ('a96980b8-8a27-11e3-88bb-001a4a81450b','b9e0c4de-8a27-11e3-88bb-001a4a81450b','1.0-swamp.1',      now(),        NULL,           NULL,               '/swamp/store/SCAPackages/UW/yazd-1.0-swamp.1/Yazd_1.0-src-swamp.1.tar.gz',                                     'Yazd_1.0-src-swamp.1',                    1,             'build.xml',        'ant',                    NULL,           'war',           '.',          '-DYasna.home=..',                                 NULL,                                                                                        NULL,                                                                                                   '.',          NULL,            '50ad8104de8e38bcbcd47fab62ddd00f862dcb4f3b3b5e7adb160e186947c360d38c210ea313f98232294d807a5611a91922eb5cf24de79b63d163f155be0129'),
        ('aa5f87a3-8a27-11e3-88bb-001a4a81450b','bac9c99c-8a27-11e3-88bb-001a4a81450b','3.0.8-swamp.1',    now(),        NULL,           NULL,               '/swamp/store/SCAPackages/UW/autopsy-3.0.8-swamp.1/autopsy-autopsy-3.0.8-swamp.1.tar.gz',                       'autopsy-autopsy-3.0.8-swamp.1',           1,             'build.xml',        'ant+ivy',                NULL,           'build',         '.',          NULL,                                              NULL,                                                                                        NULL,                                                                                                   '.',          NULL,            'a91d5f5fefd9f7fcd1beb4109c7fe9eb31a02455b2af5ce07ac7cc1d0f9a31bc245cd501d545c52c6ab6cc29488b4deacf2a2d22de7bd6dbc54b2227d50ddf54'),
        ('ab2c981c-8a27-11e3-88bb-001a4a81450b','bbac556e-8a27-11e3-88bb-001a4a81450b','3.0.3',            now(),        NULL,           NULL,               '/swamp/store/SCAPackages/UW/broadleaf-3.0.3/broadleaf-3.0.3-GA.tar.gz',                                        'BroadleafCommerce-broadleaf-3.0.3-GA',    1,             'pom.xml',          'maven',                  NULL,           'package',       '.',          NULL,                                              NULL,                                                                                        NULL,                                                                                                   '.',          NULL,            '0e3c19811f5d0be6fc75c956619474162804ea78c199128eaa5dd106964f053af8bdf7abd539694d3f9e3e12752ee82713e51ff8c62913c72789fd1203ddaa7e'),
        ('ac2a20b2-8a27-11e3-88bb-001a4a81450b','bc8fc4d9-8a27-11e3-88bb-001a4a81450b','8.0.4',            now(),        NULL,           NULL,               '/swamp/store/SCAPackages/UW/condor-8.0.4/condor_src-8.0.4-all-all.tar.gz',                                     'condor-8.0.4',                            1,              NULL,              'cmake+make',             NULL,           '',              '.',          NULL,                                              NULL,                                                                                        NULL,                                                                                                   '.',          NULL,            '84f9d67b4d4cfe3133ae4cb3345523fc8c7313d5ebbab7de7d5d1fc96fc099a88084757562b5bcee3135c005ae55ec9eccc4e20e76a7f351bf4550b1d2c13f84'),
        ('ad171e52-8a27-11e3-88bb-001a4a81450b','bd6ab38e-8a27-11e3-88bb-001a4a81450b','2.2.0',            now(),        NULL,           NULL,               '/swamp/store/SCAPackages/UW/ddf-2.2.0/ddf-2.2.0.tar.gz',                                                       'ddf-ddf-2.2.0',                           1,             'pom.xml',          'maven',                  NULL,           'install',       '.',          NULL,                                              NULL,                                                                                        NULL,                                                                                                   '.',          NULL,            'bf5d539f8a1678669380286b066c701d6a49c58082738bec9d23d73f4ad94671f484ecb590b23b81b4018a7597ee9c90f20711567d96fcc005532195c12eaf40'),
        ('ae01a89a-8a27-11e3-88bb-001a4a81450b','be468a13-8a27-11e3-88bb-001a4a81450b','3.3',              now(),        NULL,           NULL,               '/swamp/store/SCAPackages/UW/jacorb-3.3/jacorb-3.3-source.tar.gz',                                              'JacORB-RELEASE_3_3',                      1,             'build.xml',        'ant+ivy',                NULL,           '',              '.',          NULL,                                              NULL,                                                                                        NULL,                                                                                                   '.',          NULL,            '2b4db0bd1d38d11a6ed68691cf8e4952d3ad02a0f82176eb769ed8ba60c6de0d4e596b871eafe8b6fa26fe54d02ed4d4b8692a6ab0c9707c2bf7de5d6c987154'),
        ('aed44b51-8a27-11e3-88bb-001a4a81450b','51a04e34-36a8-11e3-9a3e-001a4a81450b','4.5.0',            now(),        NULL,           NULL,               '/swamp/store/SCAPackages/UW/lucene-4.5.0/lucene-4.5.0.tgz',                                                    'lucene-4.5.0',                            1,             'build.xml',        'ant+ivy',                NULL,           'compile',       '.',          NULL,                                              NULL,                                                                                        NULL,                                                                                                   '.',          NULL,            '154ac07c9b09d212d09460c59211ce194e4210bf35b072c1e72bb7402ae50b7ffda67292ee97da06607af6399a6541fd81f4ffa9ccfd3d4cebd1ad76b5682e71'),
        ('afaae50e-8a27-11e3-88bb-001a4a81450b','bf24bfb2-8a27-11e3-88bb-001a4a81450b','4.1.7',            now(),        NULL,           NULL,               '/swamp/store/SCAPackages/UW/omniORB-4.1.7/omniORB-4.1.7.tar.bz2',                                              'omniORB-4.1.7',                           1,              NULL,              'configure+make',         NULL,           '',              '.',          NULL,                                              NULL,                                                                                        NULL,                                                                                                   '.',          NULL,            '9bfad88232e1985056c444b92963bd3b7dab1018e355c2d8ace61eded062c51ae3d1aecabaecb0441e287cd5c79d1010bbdf8f194e61f6a3f05f9acae53bc3ae'),
        ('b0870aae-8a27-11e3-88bb-001a4a81450b','c00d7a12-8a27-11e3-88bb-001a4a81450b','3.6.0',            now(),        NULL,           NULL,               '/swamp/store/SCAPackages/UW/openfire-3.6.0/openfire-3.6.0.tar.gz',                                             'openfire-3.6.0',                          1,             'build/build.xml',  'ant+ivy',                NULL,           'openfire plugins', '.',       NULL,                                              NULL,                                                                                        NULL,                                                                                                   '.',          NULL,            'e36e9eedd6cc0f752a459124e5620e4b6d5fb3dcc4dbd6b2f9d57f85b0a9b0e72bca82d29f3cfeb5544cb6b93746d418f2c2e40b589348eda13e7da7b38f88d8'),
        ('b163f590-8a27-11e3-88bb-001a4a81450b','c0f68c0c-8a27-11e3-88bb-001a4a81450b','3.6.4',            now(),        NULL,           NULL,               '/swamp/store/SCAPackages/UW/openfire-3.6.4/openfire-3.6.4.tar.gz',                                             'openfire-3.6.4',                          1,             'build/build.xml',  'ant+ivy',                NULL,           'openfire plugins', '.',       NULL,                                              NULL,                                                                                        NULL,                                                                                                   '.',          NULL,            '275e5b726dc065fcb9d1aa840a86e5ecbc80179f2f4905e2a743e5a9efabb3014898c54d486d4ec47da5457987a4a16a304f902a72ae86714b6d265c081b1fe9'),
        ('b23a66c2-8a27-11e3-88bb-001a4a81450b','c1bf3274-8a27-11e3-88bb-001a4a81450b','1.6.5',            now(),        NULL,           NULL,               '/swamp/store/SCAPackages/UW/openmpi-1.6.5/openmpi-1.6.5.tar.bz2',                                              'openmpi-1.6.5',                           1,              NULL,              'configure+make',         NULL,           '',                 '.',       NULL,                                              NULL,                                                                                        NULL,                                                                                                   '.',          NULL,            'b0ede0264cd9263b8ba59ec51d17ad47b5f20d49d219ca05f7c396d608398d517b2023a46a2535fd6191160d709e4805c4de436dcfee56eda287383bd69f9652'),
        ('b317119a-8a27-11e3-88bb-001a4a81450b','c292c02e-8a27-11e3-88bb-001a4a81450b','3.0.2',            now(),        NULL,           NULL,               '/swamp/store/SCAPackages/UW/R-3.0.2/R-3.0.2.tar.gz',                                                           'R-3.0.2',                                 1,              NULL,              'configure+make',         NULL,           '',                 '.',       NULL,                                              NULL,                                                                                        NULL,                                                                                                   '.',          NULL,            '206e29679d33d8804ae230e21d87ab125d8a46fc1958feea09de338ed33806865961e2ac0ecaed873bb27a15f9ccc39c0aa750240bfe03d060c1e2c042a5bedd'),
        ('b3e32f33-8a27-11e3-88bb-001a4a81450b','c36dd4c3-8a27-11e3-88bb-001a4a81450b','5.4',              now(),        NULL,           NULL,               '/swamp/store/SCAPackages/UW/webgoat-5.4/webgoat-5.4.tar.gz',                                                   'webgoat-5.4',                             1,             'pom.xml',          'maven',                  NULL,           '',                 '.',       NULL,                                              NULL,                                                                                        NULL,                                                                                                   '.',          NULL,            'e2a376ec5f0e729514cb5c00dc20c21b0a54fd483812c7bd6fac451d550a3f287d7a310cceab6001dbe17fc7072c3ba20c6aa4b322dc582db28047b7802afc40'),
        ('b4b250dc-8a27-11e3-88bb-001a4a81450b','4bebc141-3a96-11e3-9a3e-001a4a81450b','1.2.9',            now(),        NULL,           NULL,               '/swamp/store/SCAPackages/UW/wireshark-1.2.9/wireshark-1.2.9.tar.bz2',                                          'wireshark-1.2.9',                         1,              NULL,              'configure+make',         NULL,           '',                 '.',       NULL,                                              NULL,                                                                                        NULL,                                                                                                   '.',          NULL,            'd3096f563d4b1d613897c4e0f7f6d817baf82d7b470380e7a7b841e70ccab8a30c6d1ec8cfad5c6852af929b3eae6b0df5a18f2f446bfcd0f8622a59e18cd762');

        update package_store.package_version set version_sharing_status = 'PUBLIC' where package_version_uuid in
          ('9659c792-8a27-11e3-88bb-001a4a81450b','a1468dd8-8a27-11e3-88bb-001a4a81450b','a63a4f99-8a27-11e3-88bb-001a4a81450b','a75ecab2-8a27-11e3-88bb-001a4a81450b','a865972b-8a27-11e3-88bb-001a4a81450b',
           'a96980b8-8a27-11e3-88bb-001a4a81450b','aa5f87a3-8a27-11e3-88bb-001a4a81450b','ab2c981c-8a27-11e3-88bb-001a4a81450b','ac2a20b2-8a27-11e3-88bb-001a4a81450b','ad171e52-8a27-11e3-88bb-001a4a81450b',
           'ae01a89a-8a27-11e3-88bb-001a4a81450b','aed44b51-8a27-11e3-88bb-001a4a81450b','afaae50e-8a27-11e3-88bb-001a4a81450b','b0870aae-8a27-11e3-88bb-001a4a81450b','b163f590-8a27-11e3-88bb-001a4a81450b',
           'b23a66c2-8a27-11e3-88bb-001a4a81450b','b317119a-8a27-11e3-88bb-001a4a81450b','b3e32f33-8a27-11e3-88bb-001a4a81450b','b4b250dc-8a27-11e3-88bb-001a4a81450b');

        # update database version number
        insert into assessment.database_version (database_version_no, description) values (script_version_no, 'upgrade');

        commit;
      end;
    end if;
END
$$
DELIMITER ;